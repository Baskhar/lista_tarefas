import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

//resposvel pela minha lista
class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo; //resposável por enviar uma mensagem ao whidth(por parametro)
  final Function(Todo) onDelete;//pegando a referência do pai


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        //whidth resposvel por animações de arrasto
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          //colocando bordas redondas
          //margin: const EdgeInsets.symmetric(vertical: 2),
          //afastando(espaço externo) um conteiner do outro na vertical em 2
          padding: const EdgeInsets.all(16),
          //espaço interno
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //ocupar maior largura possivel
            //alinhando os textos a esquerdas
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(todo.dateTime),
                //data e horário
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actionExtentRatio: 0.25,
        actionPane: const SlidableDrawerActionPane(), //tipo de animação
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: 'Deletar', //texto dentro do icon
            onTap: (){
              onDelete(todo);//quando pressionado ele deleta
            }

          ),
        ],
      ),
    );
  }
}
