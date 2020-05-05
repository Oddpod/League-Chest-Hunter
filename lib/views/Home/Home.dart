import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:league_chest_hunter/state/summoner.dart';
import 'package:league_chest_hunter/views/Home/CompletedChests.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void saveLastSummonerInput(summonerName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSummonerInput', summonerName);
  }

  void loadLastSummonerInput() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String lastSummonerInput = prefs.getString('lastSummonerInput');
    print(lastSummonerInput);
    setState(() {
      _controller.text = lastSummonerInput;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, loadLastSummonerInput);
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: new ScopedModelDescendant<SummonerModel>(
        builder: (context, child, model) => FloatingActionButton(
          onPressed: () {
            if (_controller.text.trim().length > 0) {
              model.fetchSummoner(_controller.text);
              saveLastSummonerInput(_controller.text);
            }
          },
          tooltip: 'Refresh',
          child: Icon(Icons.refresh),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
