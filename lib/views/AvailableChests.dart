import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/api/championMastery.dart';
import 'package:league_chest_hunter/api/summoner.dart';
import 'package:league_chest_hunter/helpers/champs.dart';
import 'package:league_chest_hunter/models/ChampMastery.dart';
import 'package:league_chest_hunter/widgets/ChampGrid.dart';

class AvailableChests extends StatefulWidget {
  final String title = "Chest Overview";

  @override
  _AvailableChestsState createState() => _AvailableChestsState();
}

class _AvailableChestsState extends State<AvailableChests> {
  TextEditingController _controller;
  List<ChampMastery> _championsWithMastery = [];
  Map<int, String> champNameDict = new Map();
  String summonerName = "Knightalot";
  Map<String, String> cachedSummoners = new Map();
  List<ChampMastery> _champsWithChestsAvailable = [];
  void _fetchSummoner(BuildContext context) async {
    print(summonerName);
    String summonerId;
    print(cachedSummoners.containsKey(summonerName));
    if (cachedSummoners.containsKey(summonerName)) {
      summonerId = cachedSummoners[summonerName];
    } else {
      summonerId = await getSummonerId(summonerName);
    }
    print(summonerId);
    var champs = await getChampionsWithMastery(summonerId);
    champs.map((champ) => champ.name);
    var champsWithChestsAvailable = champs
        .map((champ) {
          champ.name = champNameDict[champ.id];
          return champ;
        })
        .where((element) => element.chestAvailable == true)
        .toList();
    champsWithChestsAvailable.sort((a, b) => a.name.compareTo(b.name));
    print(champs.length);
    print(champsWithChestsAvailable.length);
    setState(() {
      _championsWithMastery = champs;
      _champsWithChestsAvailable = champsWithChestsAvailable;
      cachedSummoners[summonerName] = summonerId;
    });
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      loadChampNameDict(context).then((value) => champNameDict = value);
    });
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Summoner name'),
          onChanged: (input) => summonerName = input,
        ),
        ChampGrid(
            champList: _champsWithChestsAvailable, champNameDict: champNameDict)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchSummoner(context),
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes
    );
  }
}
