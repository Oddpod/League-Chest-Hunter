import 'dart:convert';
import 'package:flutter/cupertino.dart';

Future<Map<int, String>> loadChampNameDict(context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString("assets/champion/championsById.json");
  Map<String, dynamic> jsonResult = json.decode(data);
  var champNameById = new Map<int, String>();
  // print(data);
  // print(jsonResult[champs[0].id.toString()]);
  jsonResult.forEach((jsonChampId, jsonChampName) {
    champNameById[int.parse(jsonChampId)] = jsonChampName as String;
  });
  return champNameById;
}
