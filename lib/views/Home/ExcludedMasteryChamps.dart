import 'package:flutter/cupertino.dart';
import 'package:league_chest_hunter/models/summoner.dart';
import 'package:league_chest_hunter/widgets/ChampGrid.dart';
import 'package:provider/provider.dart';

class ExcludedMasteryChamps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final summoner = Provider.of<Summoner>(context);
    return ChampGrid(champList: summoner.excludedChamps);
  }
}
