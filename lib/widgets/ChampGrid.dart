import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';

class ChampGrid extends StatelessWidget {
  ChampGrid({Key key, this.champList});

  final List<ChampMastery> champList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        children: List.generate(champList.length, (index) {
          var champMastery = champList[index];
          return new Card(
            elevation: 10.0,
            child: new Container(
              child: new Image.asset(
                  'assets/champion/tiles/${champMastery.name}_0.jpg'),
            ),
          );
        }),
      ),
    );
  }
}
