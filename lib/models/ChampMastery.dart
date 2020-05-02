class ChampMastery {
  int id;
  bool chestAvailable;
  String name;
  ChampMastery({this.id, this.chestAvailable});

  ChampMastery.fromJson(dynamic json) {
    id = json['championId'];
    chestAvailable = !json['chestGranted'];
  }
}
