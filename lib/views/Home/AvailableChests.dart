import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/models/summoner.dart';
import 'package:league_chest_hunter/widgets/EditableChampGrid.dart';
import 'package:provider/provider.dart';

class AvailableChests extends StatelessWidget {
  AvailableChests({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  Widget build(BuildContext context) {
    final summoner = Provider.of<Summoner>(context);
    return new EditableChampGrid(
      champList: summoner.champsWithAvailableChests,
      batchAction: (selectedIds) => summoner.putChampsIntoExcluded(selectedIds),
    );
  }
}
