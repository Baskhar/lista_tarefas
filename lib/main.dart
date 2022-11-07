import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';

void main(){//função inical do dart
  runApp(const MyApp());//comando para rodar o apk
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,//tirando o aviso de modo debug
      home: TodoListPage(),//parâmetro que especifica a tela inical do apk
    );
  }
}

