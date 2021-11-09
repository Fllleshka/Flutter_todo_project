import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _userToDo = '';
  List todoList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.addAll(['Встать','Почистить зубы','Заправить кровать']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Меню'),
              centerTitle: true,
            ),
            body: Row(
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                    child: Text('На главную')),
              ],
            ),
          );
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.menu_outlined),
              onPressed: _menuOpen,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                    icon: Icon(
                      Icons.delete_sweep,
                      color: Colors.blueAccent,
                      ),
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                    ),
                  ),
                ),
                onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                      setState(() {
                        todoList.removeAt(index);
                      });
                    }
                    else if (direction == DismissDirection.startToEnd){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Удалено'),
                              content: Text('Дело вернулось в пустоту'),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  setState(() {
                                    todoList.removeAt(index);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Закрыть')),
                              ],
                            );
                          });
                    }
                },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('Добавить элемент'),
                  content: TextField(
                    onChanged: (String value) {
                      _userToDo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(onPressed: (){
                      setState(() {
                        todoList.add(_userToDo);
                      });
                      Navigator.of(context).pop();
                    },
                        child: Text('Добавить')
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
    );
  }
}
