import 'package:combos/combos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummonerSelector extends StatefulWidget {
  SummonerSelector(
      {Key key, this.suggestions, this.controller, this.onSelectionChanged})
      : super(key: key);

  final List<String> suggestions;
  final TextEditingController controller;
  final Function onSelectionChanged;

  @override
  State<StatefulWidget> createState() => _SummonerSelectorState();
}

class _SummonerSelectorState extends State<SummonerSelector> {
  @override
  Widget build(BuildContext context) {
    print(widget.suggestions);
    return Padding(
      padding: EdgeInsets.all(10),
      child: TypeaheadCombo<String>(
        selected: widget.controller.text,
        getList: (text) async {
          await Future.delayed(const Duration(milliseconds: 500));
          return widget.suggestions;
        },
        onItemTapped: (item) => setState(() => widget.controller.text = item),
        getItemText: (item) => item,
        decoration: const InputDecoration(labelText: 'Summoner name'),
        onSelectedChanged: (String value) {
          widget.onSelectionChanged(value);
        },
        itemBuilder: (BuildContext context, ComboParameters parameters,
            String item, bool selected, String text) {
          return ListTile(title: Text(item ?? '<Empty>'));
        },
      ),
    );
  }
}
