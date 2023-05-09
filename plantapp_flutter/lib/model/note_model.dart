class NotesModel {
late int id;
late String title;
late String body;
// ignore: non_constant_identifier_names
late DateTime creation_date;


// ignore: non_constant_identifier_names
NotesModel({required this.id, required this.title, required this.body, required this.creation_date});


Map<String, dynamic> toMap(){
return({
"id":id,
"title":title,
"body":body,
"creation_date": creation_date


});
}
}