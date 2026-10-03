import 'package:flutter/material.dart';
import 'package:todolist/cadastro_page.dart';
import 'package:todolist/models/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          ListView.separated(
            itemCount: _lista.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, position) {
              Task item = _lista[position];
              //parei aqui

              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.green,
                  child: const Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment(0.9, 0.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      _lista.removeAt(position);
                    });
                  }
                },

                child: ListTile(
                  title: Text(
                    item.texto,
                    style: TextStyle(
                      color: item.done ? Colors.grey : Colors.white,
                      fontSize: 18,
                      decoration: item.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      item.done = !item.done;
                    });
                  },
                ),

                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    Task editedTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPage(tarefa: item),
                      ),
                    );

                    if (editedTask != null) {
                      setState(() {
                        _lista.removeAt(position);
                        _lista.insert(position, editedTask);
                      });
                    }
                    return false;
                  } else if (direction == DismissDirection.endToStart) {
                    return true;
                  }
                },
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () async {
          try {
            Task todo = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CadastroPage()),
            );
            setState(() {
              _lista.add(todo);
            });
          } catch (error) {
            print("Error: ${error.toString()}");
          }
        },

        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
