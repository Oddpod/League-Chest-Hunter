import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<int, String>> loadChampNameDict() async {
  String data =
      await rootBundle.loadString("assets/champion/championsById.json");
  Map<String, dynamic> jsonResult = json.decode(data);
  var champNameById = new Map<int, String>();
  jsonResult.forEach((jsonChampId, jsonChampName) {
    champNameById[int.parse(jsonChampId)] = jsonChampName as String;
  });
  return champNameById;
}
