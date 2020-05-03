import 'package:flutter/material.dart';
import 'package:league_chest_hunter/state/summoner.dart';
import 'package:league_chest_hunter/widgets/ChampGrid.dart';
import 'package:scoped_model/scoped_model.dart';

class CompletedChests extends StatefulWidget {
  CompletedChests({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AvailableChestsState createState() => _AvailableChestsState();
}

class _AvailableChestsState extends State<CompletedChests> {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<SummonerModel>(
      builder: (context, child, model) =>
          ChampGrid(champList: model.champsWithoutChestAvailable),
    );
  }
}
