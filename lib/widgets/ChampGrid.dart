import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';

class ChampGrid extends StatelessWidget {
  final Set<int> selectedChampIndices;
  final Function onTap;
  final Function onLongPress;
  ChampGrid(
      {Key key,
      this.champList,
      this.selectedChampIndices,
      this.onTap,
      this.onLongPress});

  final List<ChampMastery> champList;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      children: List.generate(champList.length, (index) {
        var champMastery = champList[index];
        var isSelected = selectedChampIndices != null
            ? selectedChampIndices.contains(champMastery.id)
            : false;
        return new GestureDetector(
          onLongPress: () =>
              (onLongPress != null ? onLongPress(champMastery) : {}),
          onTap: () => (onTap != null ? onTap(champMastery) : {}),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: isSelected
                ? BoxDecoration(
                    border: Border.all(
                      color: Colors.greenAccent,
                      width: 8,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  )
                : BoxDecoration(),
            child: Card(
              elevation: isSelected ? 30.0 : 10.0,
              child: new Container(
                child: new Image.asset(
                    'assets/champion/tiles/${champMastery.name}_0.jpg'),
              ),
            ),
          ),
        );
      }),
    );
  }
}
