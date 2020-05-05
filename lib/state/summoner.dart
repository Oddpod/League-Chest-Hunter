import 'package:league_chest_hunter/api/championMastery.dart';
import 'package:league_chest_hunter/api/summoner.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';
import 'package:scoped_model/scoped_model.dart';

class SummonerModel extends Model {
  SummonerModel(this.champNameDict);

  List<ChampMastery> _championsWithMastery = [];
  Map<int, String> champNameDict = new Map();
  Set<ChampMastery> _excludedChamps = new Set();
  Map<String, String> cachedSummoners = new Map();

  List<ChampMastery> get championsWithMastery => _championsWithMastery;
  List<ChampMastery> get excludedChamps => _excludedChamps.toList();
  List<ChampMastery> get champsWithChestsAvailable => _championsWithMastery
      .where((champ) => champ.chestAvailable == true)
      .toList();
  List<ChampMastery> get champsWithoutChestAvailable => _championsWithMastery
      .where((champ) => champ.chestAvailable == false)
      .toList();

  setChampsWithMastery(List<ChampMastery> champs) {
    _championsWithMastery = champs
      ..map((champ) {
        champ.name = champNameDict[champ.id];
        return champ;
      }).toList();
    _championsWithMastery.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  putChampsIntoExcluded(List<int> champIds) {
    champIds.forEach((champId) {
      final excludedChamp =
          _championsWithMastery.firstWhere((champ) => champ.id == champId);
      excludedChamps.add(excludedChamp);
      _championsWithMastery.removeWhere((champ) => champ.id == champId);
    });
  }

  void fetchSummoner(name) async {
    print(name);
    String summonerId;
    print(cachedSummoners.containsKey(name));
    if (cachedSummoners.containsKey(name)) {
      summonerId = cachedSummoners[name];
    } else {
      summonerId = await getSummonerId(name);
    }
    print(summonerId);
    var champs = await getChampionsWithMastery(summonerId);
    print(champs.length);
    print(champsWithChestsAvailable.length);
    setChampsWithMastery(champs);
    cachedSummoners[name] = summonerId;
  }
}
