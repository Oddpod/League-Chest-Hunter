import 'package:flutter/material.dart';
import 'package:league_chest_hunter/widgets/DropdownMenu.dart';

class SummonerSelector extends StatelessWidget {
  SummonerSelector(
      {Key key,
      @required this.options,
      @required this.controller,
      @required this.selectionChanged})
      : super(key: key);

  final TextEditingController controller;
  final List<String> options;
  final Function selectionChanged;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Row(
        children: <Widget>[
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(3),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Summoner name',
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(4),
            child: DropdownMenu(
              onSelected: (selected) => selectionChanged(selected),
              items: options,
            ),
          ),
        ],
      ),
    );
  }
}
