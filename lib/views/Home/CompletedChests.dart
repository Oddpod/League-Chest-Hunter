import 'package:flutter/material.dart';
import 'package:league_chest_hunter/models/summoner.dart';
import 'package:league_chest_hunter/state/summoner.dart';
import 'package:league_chest_hunter/widgets/ChampGrid.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class CompletedChests extends StatelessWidget {
  CompletedChests({Key key, this.title}) : super(key: key);
  final String title;

  Widget build(BuildContext context) {
    final summoner = Provider.of<Summoner>(context);
    return ChampGrid(champList: summoner.champsWithoutChestAvaiable);
  }
}
