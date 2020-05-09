import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:league_chest_hunter/api/championMastery.dart';
import 'package:league_chest_hunter/api/summoner.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';
import 'package:league_chest_hunter/helpers/champs.dart';
import 'package:league_chest_hunter/helpers/io.dart';
import 'package:league_chest_hunter/helpers/sorting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summoner with ChangeNotifier {
  List<ChampMastery> _champsWithMastery = [];
  String _currentSummonerName;
  String get name => _currentSummonerName;

  bool hasChestAvailable(champ) =>
      champ.chestAvailable && !_excludedChampIds.contains(champ.id);
  List<ChampMastery> get champsWithAvailableChests =>
      _champsWithMastery.where(hasChestAvailable).toList();

  List<ChampMastery> get champsWithoutChestAvaiable =>
      _champsWithMastery.where((champ) => !champ.chestAvailable).toList();

  List<ChampMastery> get excludedChamps => _champsWithMastery
      .where((champ) => _excludedChampIds.contains(champ.id))
      .toList();
  Set<int> _excludedChampIds = new Set();
  Map<String, String> _cachedSummoners = new Map();

  List<String> get cachedSummonerNames => _cachedSummoners.keys.toList();

  Map<int, String> _champNameDict = new Map();
  Summoner() {
    loadChampNameDict().then((value) => _champNameDict = value);
    loadSavedData();
  }

  void loadSavedData() async {
    await loadSavedSummonerName();
    await loadSavedSummonerChamps();
    await loadCachedSummoners();
    loadExcludedChampIds();
  }

  Future<void> loadCachedSummoners() async {
    var jsonCached = await readFile('cachedSummoners.json');
    if (jsonCached == null) {
      return;
    }
    Map<String, String> savedSummoners = Map.castFrom(json.decode(jsonCached));
    _cachedSummoners.clear();
    _cachedSummoners.addAll(savedSummoners);
    notifyListeners();
  }

  void saveCachedSummoners() {
    var jsonCached = json.encode(_cachedSummoners);
    saveFile('cachedSummoners.json', jsonCached);
  }

  void loadSavedSummoner(name) async {
    if (!_cachedSummoners.containsKey(name)) {
      fetchChamps(name);
      return;
    }
    await setLastSummonerName(name);
    await loadSavedSummonerChamps();
    loadExcludedChampIds();
  }

  void setChamps(List<ChampMastery> champs) {
    champs.forEach((champ) {
      champ.name = _champNameDict[champ.id];
    });
    champs.sort(alphabeticSort);
    _champsWithMastery = champs;
    notifyListeners();
  }

  void fetchChamps(String summonerName) async {
    String summonerId;
    if (_cachedSummoners.containsKey(summonerName)) {
      summonerId = _cachedSummoners[summonerName];
    } else {
      summonerId = await getSummonerId(summonerName);
      _cachedSummoners[summonerName] = summonerId;
      saveCachedSummoners();
    }
    setChamps(await getChampionsWithMastery(summonerId));
    if (summonerName != _currentSummonerName) {
      await setLastSummonerName(summonerName);
      loadExcludedChampIds();
      return;
    }
    await setLastSummonerName(summonerName);
    saveSummonerChamps();
  }

  void putChampsIntoExcluded(Set<int> champIdsToExclude) {
    champIdsToExclude.forEach((champToExcludeId) {
      _excludedChampIds.add(champToExcludeId);
    });
    saveExcludedChampsIds();
    notifyListeners();
  }

  void saveExcludedChampsIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedExcludedChampsIds$_currentSummonerName',
        _excludedChampIds.map((id) => id.toString()).toList());
  }

  Future<void> loadSavedSummonerName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedSummnerInput = prefs.getString('lastSummonerInput');
    if (savedSummnerInput == null) {
      return;
    }
    _currentSummonerName = savedSummnerInput;
    notifyListeners();
  }

  Future<void> setLastSummonerName(summonerName) async {
    _currentSummonerName = summonerName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSummonerInput', summonerName);
  }

  void loadExcludedChampIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedExcludedChampIds =
        prefs.getStringList('savedExcludedChampsIds$_currentSummonerName');
    if (savedExcludedChampIds == null) {
      return;
    }
    _excludedChampIds =
        savedExcludedChampIds.map((stringId) => int.parse(stringId)).toSet();
    notifyListeners();
  }

  void includeChamps(Set<int> idsToInclude) {
    idsToInclude.forEach((champIdToInclude) {
      _excludedChampIds.removeWhere(
          (excludedChampId) => excludedChampId == champIdToInclude);
    });
    notifyListeners();
  }

  saveSummonerChamps() async {
    await saveFile(_currentSummonerName, json.encode(_champsWithMastery));
  }

  loadSavedSummonerChamps() async {
    String jsonSavedChamps = await readFile(_currentSummonerName);
    if (jsonSavedChamps == null) {
      return;
    }
    Iterable champsJson = json.decode(jsonSavedChamps);
    List<ChampMastery> champs = champsJson
        .map((dynamic champJson) => ChampMastery.fromJson(champJson))
        .toList();
    setChamps(champs);
  }
}
