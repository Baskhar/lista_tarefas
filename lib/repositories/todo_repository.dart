import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';
const todoListKey = 'todo_list';

class TodoRepositiry {
  late SharedPreferences sharedPreferences;//instanciando o sharedpreferences
  //repository de dados


  Future<List<Todo>> getTodosList()async{//função assinctona onde irá instanciar uma vez o Shared
    sharedPreferences = await SharedPreferences.getInstance();
    final  String jsonString = sharedPreferences.getString(todoListKey)?? '[]';//json que simboliza uma lista valiza;
    final List jsonDecoded = json.decode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();//convetendo de json para list
  }


  void saveTodoList(List<Todo> todos) {//criando uma função onde ela vai pegar as notações em jason e armazenar
    final String jsonString = json.encode(todos);
    sharedPreferences.setString(todoListKey, jsonString);
  }
}
