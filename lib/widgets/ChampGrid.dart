import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/models/ChampMastery.dart';

class ChampGrid extends StatelessWidget {
  ChampGrid({Key key, this.champList, this.champNameDict});

  final List<ChampMastery> champList;
  final Map<int, String> champNameDict;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        children: List.generate(champList.length, (index) {
          var champMastery = champList[index];
          String champName = champNameDict[champMastery.id];
          // print(champName);
          return new Card(
            elevation: 10.0,
            child: new Container(
              child:
                  new Image.asset('assets/champion/tiles/${champName}_0.jpg'),
            ),
          );
        }),
      ),
    );
  }
}
