import 'package:flutter/cupertino.dart';
import 'package:league_chest_hunter/state/summoner.dart';
import 'package:league_chest_hunter/widgets/ChampGrid.dart';
import 'package:scoped_model/scoped_model.dart';

class ExcludedMasteryChamps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ScopedModelDescendant<SummonerModel>(
      builder: (context, child, model) =>
          new ChampGrid(champList: model.excludedChamps),
    );
  }
}
