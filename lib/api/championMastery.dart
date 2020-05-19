import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:league_chest_hunter/entities/ChampMastery.dart';

var endpoint = "${DotEnv().env['API_ENDPOINT']}";
class ChampMasteryResponse {
  String summonerId;
  List<ChampMastery> championMastery;
}
Future<ChampMasteryResponse> getChampionsWithMastery(String summonerName, { String summonerId }) async {
  var client = http.Client();
  var saveSummonerId = false;
  Map data = {'name': summonerName};
  if(summonerId != null){
    data.putIfAbsent('summonerId', () => summonerId);
  } else {
    saveSummonerId = true;
  }
  var body = json.encode(data);

  try {
    var response = await client.post(endpoint,
        body: body, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var champMasteryResponse = ChampMasteryResponse();
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if(saveSummonerId) {
        champMasteryResponse.summonerId = jsonResponse['summonerId'];
      }
      champMasteryResponse.championMastery = jsonResponse['championMastery']
          .map((dynamic model) => ChampMastery.fromJson(model))
          .toList();
      return champMasteryResponse;
    } else {
      throw new Error();
    }
  } finally {
    client.close();
  }
}
