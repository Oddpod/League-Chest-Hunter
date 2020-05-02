import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const RIOT_API_ROOT_LOL = "https://euw1.api.riotgames.com/lol/";

class APIClient extends http.BaseClient {
  final http.Client _inner;

  APIClient(this._inner);

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['X-Riot-Token'] = DotEnv().env['API_KEY'];
    return _inner.send(request);
  }
}
