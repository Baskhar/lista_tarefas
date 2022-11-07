class Todo{//classe que será o modelo da minha lista
  //armazena do titulo e a data
  Todo({required this.title, required this.dateTime});
  String title;
  DateTime dateTime;

  Todo.fromJson(Map<String,dynamic>json)
    : title = json['title'],
      dateTime = DateTime.parse(json['datetime']);//convetendo de string para datetime

  //transformando a lista em jason
  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'datetime': dateTime.toIso8601String(),//convertendo datetime em String
    };
  }

}