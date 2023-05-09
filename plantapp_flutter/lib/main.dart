import 'package:flutter/material.dart';
import 'package:plantapp_flutter/db/database_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {"/": (context) => const HomeScreen()},
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //okay now let create the future builder to diplay the element
      appBar: AppBar(
        title: const Text('Your Notes'),
      ),
      body: FutureBuilder(
          future: getNotes(),
          builder: (context, noteData) {
            switch (noteData.connectionState) {
              case ConnectionState.waiting:
                {
                  return const Center(child: CircularProgressIndicator());
                }
              case ConnectionState.done:
                {
                  //Lets check that we didn't get a null
                  if (noteData.data == Null) {
                    return const Center(
                      child: Text("You don't have any noes yet, create one"),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: noteData.data.length,
                        itemBuilder: (context, index) {
                          //setting the different items
                          // ignore: unused_local_variable
                          String title = noteData.data[index]['title'];
                          String body = noteData.data[index]['body'];
                          String creation_date =
                              noteData.data[index]['creation_date'];
                          int id = noteData.data[index]['id'];
                          return Card(
                            child: ListTile(
                              title: Text(title),
                              subtitle: Text(body),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
            }
          }),
    );
  }
}
