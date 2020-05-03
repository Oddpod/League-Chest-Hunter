import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:league_chest_hunter/helpers/champs.dart';
import 'package:league_chest_hunter/state/summoner.dart';
import 'package:scoped_model/scoped_model.dart';

import 'AvailableChests.dart';
import 'ExcludedMasteryChamps.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  Map<int, String> champNameDict = new Map();
  String _summonerNameInput;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    AvailableChests(title: "Available chests Overview"),
    ExcludedMasteryChamps(),
  ];

  final List<String> tabTitles = [
    'Available Chests',
    'Excluded Champs',
  ];

  TextEditingController _controller;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      loadChampNameDict(context).then((value) => champNameDict = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<SummonerModel>(
      model: new SummonerModel(champNameDict),
      child: Scaffold(
        appBar: AppBar(
          title: Text(tabTitles[_selectedIndex]),
        ),
        body: Column(children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Summoner name'),
            onChanged: (input) => _summonerNameInput = input,
          ),
          _widgetOptions.elementAt(_selectedIndex),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              title: Text('Available'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.unarchive),
              title: Text('Unowned'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        floatingActionButton: new ScopedModelDescendant<SummonerModel>(
          builder: (context, child, model) => FloatingActionButton(
            onPressed: () {
              if (_summonerNameInput.trim().length > 0) {
                model.fetchSummoner(_summonerNameInput);
              }
            },
            tooltip: 'Refresh',
            child: Icon(Icons.refresh),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
