import 'package:flutter/material.dart';

class DropdownMenu extends StatelessWidget {
  DropdownMenu({Key key, @required this.items, @required this.onSelected})
      : super(key: key);

  final List<String> items;
  final Function onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.arrow_downward),
      onSelected: changedDropDownItem,
      itemBuilder: (BuildContext context) {
        return items
            .map((item) =>
                PopupMenuItem<String>(value: item, child: new Text(item)))
            .toList();
      },
    );
  }

  void changedDropDownItem(String selected) {
    onSelected(selected);
  }
}
