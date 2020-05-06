import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';

import 'ChampGrid.dart';

class EditableChampGrid extends StatefulWidget {
  EditableChampGrid(
      {Key key, this.champList, @required this.batchAction, this.editIcon = Icons.remove})
      : super(key: key);
  final List<ChampMastery> champList;
  final Function batchAction;
  final IconData editIcon;

  @override
  _EditTableChampGridState createState() => _EditTableChampGridState();
}

class _EditTableChampGridState extends State<EditableChampGrid> {
  bool get isEditing => _selectedChampIds.isNotEmpty;
  Set<int> _selectedChampIds = new Set();
  void _enterEditMode(ChampMastery champ) {
    setState(() {
      _selectedChampIds.add(champ.id);
    });
  }

  void _onSelect(ChampMastery champ) {
    if (!isEditing) {
      return;
    }
    setState(() {
      if (_selectedChampIds.contains(champ.id)) {
        _selectedChampIds.remove(champ.id);
      } else {
        _selectedChampIds.add(champ.id);
      }
    });
  }

  void exitEditMode() {
    setState(() {
      _selectedChampIds.clear();
    });
  }

  void executeBatchAction() {
    widget.batchAction(
      _selectedChampIds,
    );
    setState(() {
      _selectedChampIds.clear();
    });
  }

  bool notNull(Object o) => o != null;
  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      ChampGrid(
        champList: widget.champList,
        selectedChampIndices: _selectedChampIds,
        onTap: (champ) => _onSelect(champ),
        onLongPress: (champ) => _enterEditMode(champ),
      ),
    ];
    if (isEditing) {
      final stopEditingButton = FloatingActionButton(
        onPressed: () => exitEditMode(),
        tooltip: 'Exclude',
        child: Icon(Icons.stop),
      );
      final removeSelectedButton = FloatingActionButton(
        onPressed: () => executeBatchAction(),
        tooltip: 'Exclude',
        child: Icon(widget.editIcon),
      );
      final editRow = Positioned(
        left: 10.0,
        bottom: 10.0,
        child: Row(children: <Widget>[stopEditingButton, removeSelectedButton]),
      );
      widgets.add(editRow);
    }
    return new Stack(
      children: widgets,
    );
  }
}
