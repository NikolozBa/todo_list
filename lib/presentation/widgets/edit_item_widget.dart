import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/data/database_helper.dart';
import 'package:todo_list/data/todo_item_model.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';

class EditTodoItem extends StatefulWidget {
  final QueryDocumentSnapshot todoItem;
  const EditTodoItem({Key? key, required this.todoItem}) : super(key: key);

  @override
  _EditTodoItemState createState() => _EditTodoItemState(todoItem);
}

class _EditTodoItemState extends State<EditTodoItem> {

  late QueryDocumentSnapshot todoItem;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController task = TextEditingController();
  final TextEditingController description = TextEditingController();

  _EditTodoItemState(var todoItem){
    this.todoItem = todoItem;
    title.text = todoItem["title"];
    task.text = todoItem["task"];
    description.text = todoItem["description"];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.06),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.lato(fontSize: 25, color: Colors.white),
                      controller: title,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        hintStyle: GoogleFonts.lato(fontSize: 25, color: Color(0xff92d4d1)),
                        hintText: "please enter title",
                      ),
                      validator: (input){
                        if(input == "" || input == null){
                          return "please enter title";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.lato(fontSize: 25, color: Colors.white),
                      controller: task,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        hintStyle: GoogleFonts.lato(fontSize: 25, color: Color(0xff92d4d1)),
                        hintText: "please enter task",
                      ),
                      validator: (input){
                        if(input == "" || input == null){
                          return "please enter task";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: GoogleFonts.lato(fontSize: 25, color: Colors.white),
                      controller: description,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2)
                        ),
                        hintStyle: GoogleFonts.lato(fontSize: 25, color: Color(0xff92d4d1)),
                        hintText: "please enter description",
                      ),
                      validator: (input){
                        if(input == "" || input == null){
                          return "please enter description";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: TextButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          DatabaseHelper.updateTodoItem(
                              id: todoItem.id,
                              data: TodoItem(
                                  title: title.text,
                                  task: task.text,
                                  description: description.text,
                                  completed: todoItem["completed"]
                              )
                          );
                          BlocProvider.of<TodoCubit>(context).reset();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "EDIT",
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size(width*0.3,0),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
