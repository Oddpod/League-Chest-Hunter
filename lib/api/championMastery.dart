import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:league_chest_hunter/api/request.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';

var endpoint =
    '${RIOT_API_ROOT_LOL}champion-mastery/v4/champion-masteries/by-summoner';
Future<List<ChampMastery>> getChampionsWithMastery(summonerId) async {
  var client = APIClient(http.Client());
  try {
    var response = await client.get('$endpoint/$summonerId');
    if (response.statusCode == 200) {
      Iterable champList = json.decode(response.body);
      return champList
          .map((dynamic model) => ChampMastery.fromJson(model))
          .toList();
    } else {
      throw new Error();
    }
  } finally {
    client.close();
  }
}
