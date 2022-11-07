import 'package:flutter/material.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

import '../models/todo.dart';

class TodoListPage extends StatefulWidget {
  //classe da minha tela inicial
  TodoListPage({
    Key? key,
  }) : super(key: key);

  //final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepositiry todoRepositiry = TodoRepositiry();

//controlador do textField
  List<Todo> todos = []; //lista do tipo tod0(classe)
  Todo? deleteTodo; //armazena a lista deletada
  int? deletedTodoPos; //guarda a posição da lista deletada
  String? errorText;

  @override
  void initState() {
    //chamado uma única vez(quando a tela for aberta)
    super.initState();
    todoRepositiry.getTodosList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  /*final TextEditingController emailController =
      TextEditingController(); //instância que me permite tratar os dados digitado no campo de texto

   */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //whidth resposavel em manter o apk em uma área segura da tela do meu celular
      child: Scaffold(
        body: Center(
          //centraliza
          child: Padding(
            padding: const EdgeInsets.all(16),
            //colocando espaço nas laterais
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //pedindo para a coluna ocupar o menor espaço possivel
              children: [
                Row(
                  //linha
                  children: [
                    Expanded(
                      //expandir o meu campo de texto até a máxia largura da tela(pq a row é infinita)
                      child: TextField(
                        controller: todoController,
                        //colocando o controller no textfiekd
                        //campo de ttexto
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          //bordas
                          labelText: 'Adicione uma Tarefa',
                          //titulo do texto
                          hintText: 'Estudar Matemática',
                          //texto de exemplo
                          errorText: errorText,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d7f3),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8), //espaço entre o text field e o button
                    ElevatedButton(
                      onPressed: () {
                        String text = todoController
                            .text; //armazenado a informação do text field na variavel text

                        if (text.isEmpty) {
                          //se estiver vazio exibirá uma mensagem de erro
                          setState(() {
                            errorText = 'O título não pode ser vazio';
                          });

                          return;
                        }
                        setState(() {
                          //comando que muda o estado da tela(refaz a tela)
                          Todo newTodo = Todo(
                            //instanaciando a classe(objeto) todo e passando os parâmetreos do construtor
                            title: text,
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo); //adcionando o objeto a lista
                          errorText = null;
                        });
                        todoController
                            .clear(); //limpar o textfield após adcionar
                        todoRepositiry.saveTodoList(todos);
                      },
                      style: ElevatedButton.styleFrom(
                        //persinalizando o botão
                        primary: Color(0xff00d7f3),
                        padding:
                            EdgeInsets.all(14), //aumentando o tamanho do botão
                      ),
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16), //separando as 2 ROWS(altura)
                Flexible(
                  //ocupa o maior espaço possivel(mas permite scrow
                  child: ListView(
                    //componente responsavel por armazenar as tarefas
                    shrinkWrap: true,
                    //define o tamanho da minha list view de acordo com o tamanho dos itens
                    children: [
                      for (Todo todo
                          in todos) //para cada tarefa(objeto) na lista de tarefa
                        TodoListItem(
                          todo: todo,
                          //passando os dados do objeto todo para o list intem
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16), //separando as 2 ROWS(altura)
                Row(
                  children: [
                    Expanded(
                      child:
                          Text('Você possue ${todos.length} tarefas pendentes'),
                    ),
                    SizedBox(
                      width: 8,
                    ), //separa o Text do botão
                    ElevatedButton(
                        onPressed: showDeleteTodosConfirmationDialog,
                        style: ElevatedButton.styleFrom(
                          //persinalizando o botão
                          primary: Color(0xff00d7f3),
                          padding: EdgeInsets.all(
                              14), //aumentando o tamanho do botão
                        ),
                        child: Text('Limpar Tudo')),
                  ],
                )
              ],
            ),
          ),
        ),
        /*body: Center(
              //whidth que centraliza na tela
              child: Padding(
        //whidth de espaçamento
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //definindo que a coluna deve ocupar um tamanho mínimo
          children: [
            TextField(
              //filho do Center/campo de texto
              controller: emailController,
              decoration: InputDecoration(
                //decoração do text field
                labelText: 'E-mail', //título do text field
              ),
              onChanged: onChanged,//monitora o que está sendo digitado em tempo real(somente leitura)
              onSubmitted: onSubmitted,//lê após o usuário pressionar o botão de enviar(para flutter web)
              /* decoration: InputDecoration(//whidth que personaliza o textField
                       labelText: 'Email: ', //título do TextoField
                       hintText: 'exemple@exemple.com',//exemplo do que o usuário pode escrever
                       border: OutlineInputBorder(),//borda do TextField
                       errorText: null,//mensagem de erro
                       prefixText: 'R\$ ',//mensagem a ser exebida antes do input do usuário
                       suffixText: 'cm', //mensagem a ser exebida depois do input do usuário
                       labelStyle: TextStyle(//estilizando o título do TextField
                         fontSize: 20,//aumentando a fonte do titulo do TextField
                       ),

                     //obscureText: true,//deixa os caracteres digitados obscuros(para senhas)
                     //obscuringCharacter: 'X',
                     keyboardType: TextInputType.emailAddress,//muda o teclado do celular para o argumento desejado(ex numero)
                     style: const TextStyle(//personalida o estilo do TextField
                       fontSize: 20,//aumenta o tamanho da fonte
                       fontWeight: FontWeight.w700,//fonte em negrito(obs: o w representa o peso da fonte, quanto maior mais forte)
                       color: Colors.purple//muda a cor do texto
                     ),*/
            ),
            ElevatedButton(
              onPressed: login,
              //comando do botão onde o Onpressed irá receber uma função para determinar a funcionalizdade do botão
              //e no child: pode vim qualquer width
              child: Text('Entrar'),
            ),
          ],
        ),
      )));
  }

  void login() {
      //função que será enviada para o botão
      String text = emailController.text; //pegando o texto digitado no text field
      print(text);
      emailController.clear(); //limpando o texto digitado no texto field
  }

  void onChanged(String text){//função com uma String para o onchanged
        print(text);
  }

  void onSubmitted(String text){//Função com ums String para o onSubmitted
      print(text);

           */
      ),
    );
  }

  void onDelete(Todo todo) {
    deleteTodo = todo; //armazenando a lista que foi excluida
    deletedTodoPos =
        todos.indexOf(todo); //armazenando a posição da lista que foi exluida
    //função resposável por remover o ítem
    setState(() {
      todos.remove(todo);
    });
    todoRepositiry.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      //snackbar que avisará que uma tarefa foi excluída
      SnackBar(
        content: Text(
          'Tarefa ${todo.title} foi removida com sucesso!',
          //mesagem da exclusão
          style: TextStyle(color: Color(0xff060708)),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
            label: 'Desfazer',
            textColor: const Color(0xff00d7f3),
            onPressed: () {
              setState(() {
                todos.insert(deletedTodoPos!,
                    deleteTodo!); //inserindo na minha lista de todos, a tarefa que foi excluida
                todoRepositiry.saveTodoList(todos);
                //junto com a sua posição inicial
              });
            }),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    //caixa de dialogo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Limpar Tudo?'),
        //titulo
        content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
        //conteúdo
        actions: [
          TextButton(
            //botãode cancelar
            onPressed: () {
              Navigator.of(context).pop(); //fecha a caixa do dialogo
            },
            style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); //fecha a caixa do dialogo
              deleteAllTodos(); //chamando a função pra limpar tudo
            }, //botão de limpar tudo
            style: TextButton.styleFrom(primary: Colors.red),
            child: Text('Limpar Tudo'),
          ),
        ], //conteúdo
      ),
    );
  }

  void deleteAllTodos() {
    //função apagar tudo
    setState(() {
      todos.clear(); //limpar tudo da lista de todos
    });
    todoRepositiry.saveTodoList(todos);
  }
}
