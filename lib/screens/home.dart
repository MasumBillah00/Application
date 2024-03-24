
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/widgets/todo_item.dart';

class Home extends StatefulWidget {
   Home({Key?key}):super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo =todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
               searchBox(),
               Expanded(
                 child: ListView(
                  children: [Container(
                    margin: EdgeInsets.only(
                      top: 50,
                      bottom: 20,
                    ),
                    child: Text('All ToDos',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                    ),),
                  ),
          
                  for( ToDo todoo in _foundToDo.reversed )
                  ToDoItem(todo: todoo,
                  onToDoChanged: _handleToDoChange,
                  onDeleteItem: _deleteToDoChange,
                  ),
                  
                  ],
                 ),
               )
              ],
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(child:
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,
                  vertical: 5,
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: (){
                      // print('Clicked on add');
                      _addToDoItem(_todoController.text);
                    },
                   child: Text('+',style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                   ),
                   ),
                   style: ElevatedButton.styleFrom(
                    backgroundColor:tdBlue,
                    minimumSize: Size(60,60),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                    
                   ),
                   ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone =!todo.isDone;
    });
  }

  void _deleteToDoChange(String id){
    setState(() {
       todosList.removeWhere((item) => item.id ==id);
    });
   
  }

  void _addToDoItem(String toDo){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
       todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enterKeyword){
    List<ToDo> result =[];
    if(enterKeyword.isEmpty){
      result = todosList;
    }
    else{
      result = todosList.where((item) => item.todoText!.toLowerCase().contains(
        enterKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }
  

  Widget searchBox(){
    return  Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,),
                    
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      maxWidth: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'search',
                ),
              ),
            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation:0 ,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,
          color: tdBlack,
          size: 30,),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/masum.jpg'),
            ),
          )
        ],
      )
    );
  }
}