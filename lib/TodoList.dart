import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'List.dart';
 
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();
  _listTodo(Todo todo, bool isChecked){
    setState(() {
      todo.isDone = isChecked;
    });
  }
  Widget _bulidList(BuildContext context, int index){
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked){
        _listTodo(todo, isChecked);
      },
    );
  }
  _addTodo(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all( Radius.circular(16.0)),
          ),
          title: Text("Add new list"),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Cancel"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: Text("Add"),
              onPressed: (){
                setState(() {
                  final todo = new Todo(title: controller.value.text);
                  if(controller.value.text == ""){
                    print("");
                  }else{
                  todos.add(todo);
                  }
                  controller.clear();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: _bulidList,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}