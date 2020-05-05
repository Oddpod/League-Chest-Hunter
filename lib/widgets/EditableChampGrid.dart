import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:league_chest_hunter/entities/ChampMastery.dart';

import 'ChampGrid.dart';

class EditableChampGrid extends StatefulWidget {
  EditableChampGrid({Key key, this.champList, @required this.batchAction})
      : super(key: key);
  final List<ChampMastery> champList;
  final Function batchAction;

  @override
  _EditTableChampGridState createState() => _EditTableChampGridState();
}

class _EditTableChampGridState extends State<EditableChampGrid> {
  bool isEditing = false;
  List<int> _selectedChampIds = [];
  void _enterEditMode(ChampMastery champ) {
    setState(() {
      isEditing = true;
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

  bool notNull(Object o) => o != null;
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        ChampGrid(
          champList: widget.champList,
          selectedChampIndices: _selectedChampIds,
          onTap: _onSelect,
          onLongPress: _enterEditMode,
        ),
        isEditing
            ? new Positioned(
                left: 10.0,
                child: FloatingActionButton(
                  onPressed: () => widget.batchAction(
                    _selectedChampIds,
                  ),
                  tooltip: 'Exclude',
                  child: Icon(Icons.remove),
                ),
              )
            : null
      ].where(notNull).toList(),
    );
  }
}
