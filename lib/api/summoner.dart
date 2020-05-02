import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:league_chest_hunter/api/request.dart';

var endpoint = '${RIOT_API_ROOT_LOL}summoner/v4/summoners/by-name';
Future<String> getSummonerId(summonerName) async {
  var client = APIClient(http.Client());
  var response = await client.get(
      'https://euw1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName');
  var jsonData = json.decode(response.body);
  return jsonData['id'];
}
