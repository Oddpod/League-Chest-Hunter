import 'package:flutter/foundation.dart';
import 'package:league_chest_hunter/api/championMastery.dart';
import 'package:league_chest_hunter/api/summoner.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';
import 'package:league_chest_hunter/helpers/champs.dart';
import 'package:league_chest_hunter/helpers/sorting.dart';

class Summoner with ChangeNotifier {
  List<ChampMastery> _champsWithMastery = [];

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

  Map<int, String> _champNameDict = new Map();
  Summoner() {
    loadChampNameDict().then((value) => _champNameDict = value);
  }

  void setChamps(List<ChampMastery> champs) {
    champs.forEach((champ) {
      champ.name = _champNameDict[champ.id];
    });
    champs.sort(alphabeticSort);
    _champsWithMastery = champs;
    _champsWithMastery.forEach((element) {
      print(element);
    });
    notifyListeners();
  }

  void fetchChamps(summonerName) async {
    String summonerId;
    if (_cachedSummoners.containsKey(summonerName)) {
      summonerId = _cachedSummoners[summonerName];
    } else {
      summonerId = await getSummonerId(summonerName);
      _cachedSummoners[summonerName] = summonerId;
    }
    setChamps(await getChampionsWithMastery(summonerId));
  }

  void putChampsIntoExcluded(List<int> champIdsToExclude) {
    champIdsToExclude.forEach((champToExcludeId) {
      _excludedChampIds.add(champToExcludeId);
    });
    notifyListeners();
  }
}
