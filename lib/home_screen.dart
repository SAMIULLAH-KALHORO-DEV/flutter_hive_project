import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive dase')),
      body: Column(
        children: [
          FutureBuilder(
            future: Hive.openBox('kashif'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.get('name').toString()),
                    Text(snapshot.data!.get('age').toString()),
                  
                  ],
                );
              }
              return CircularProgressIndicator(); // Or any loading indicator
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await Hive.openBox('kashif');

          box.put('name', 'kashif');
          box.put('age', 22);
          // print(box.get('name'));
          // print(box.get('age'));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
