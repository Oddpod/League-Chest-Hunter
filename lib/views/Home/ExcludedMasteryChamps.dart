import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/models/summoner.dart';
import 'package:league_chest_hunter/widgets/EditableChampGrid.dart';
import 'package:provider/provider.dart';

class ExcludedMasteryChamps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final summoner = Provider.of<Summoner>(context);
    return EditableChampGrid(
        champList: summoner.excludedChamps,
        batchAction: (selectedIds) => summoner.includeChamps(selectedIds),
        editIcon: Icons.add);
  }
}
