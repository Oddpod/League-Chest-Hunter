import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:league_chest_hunter/models/summoner.dart';
import 'package:league_chest_hunter/views/Home/CompletedChests.dart';
import 'package:provider/provider.dart';

import 'AvailableChests.dart';
import 'ExcludedMasteryChamps.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Page {}

class _HomePageState extends State<Home> {
  Map<int, String> champNameDict = new Map();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    AvailableChests(title: "Available chests Overview"),
    ExcludedMasteryChamps(),
    CompletedChests(),
  ];

  final List<String> tabTitles = [
    'Available Chests',
    'Excluded Champs',
    'Completed Chests'
  ];

  TextEditingController _controller = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final summoner = Provider.of<Summoner>(context);
    _controller.text = summoner.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[_selectedIndex]),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Summoner name'),
          ),
        ),
        Expanded(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.unarchive),
            title: Text('Completed'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.trim().length > 0) {
            summoner.fetchChamps(_controller.text);
          }
        },
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
