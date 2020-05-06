class ChampMastery {
  int id;
  bool chestAvailable;
  String name;
  ChampMastery({this.id, this.chestAvailable});

  ChampMastery.fromJson(dynamic json) {
    id = json['championId'];
    chestAvailable = !json['chestGranted'];
    if (json['name'] != null) {
      name = json['name'];
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'championId': id,
        'chestGranted': !chestAvailable,
      };
}
