import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive database')),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox('kashif'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Text(snapshot.data!.get('name').toString()),
                  Text(snapshot.data!.get('age').toString()),
                  Text(snapshot.data!.get('details').toString()),
                ],
              );
            },
          ),
          FutureBuilder(
            future: Hive.openBox('names'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(children: [Text(snapshot.data!.get('youtube').toString())]);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box2 = await Hive.openBox('names');
          var box = await Hive.openBox('kashif');

          box2.put('youtube', 'randomshorts');
          box.put('name', 'sami');
          box.put('details', {'name': 'kashif', 'phone': '030'});
          box.put('age', '2');
          print(box.get('name'));
          print(box.get('details')['phone']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
