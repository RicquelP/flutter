 //now Lets make the dp provider class

 import 'package:path/path.dart';
import 'package:plantapp_flutter/model/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  // ignore: unused_field
 static Database _database;

  Future<Database> get database async{

if(_database !=null){
  return _database;
      }
     _database = await initDB();
     return _database;
  }

  initDB()  async{
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
   onCreate: (db,version) async{
      //lets create our first table
      await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        creation_date DATE

      )

      ''');
        }, version:1);

   }
   //Now lets create a fucntion that will add a new note to our variable
   addNewNote(NotesModel note)async{
    final db = await database;
    db.insert("notes", note.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);

   }
   //Create the function that will fetch our database and return all the element
  //inside the notes table 
  Future<dynamic> getNotes() async{
    final db = await database;
    var res = await db. query("notes");
    // ignore: prefer_is_empty
    if(res.length == 0) {
      return Null;

    }else{
      var resultMap =  res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }

  }
 }