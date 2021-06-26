import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/data/database_helper.dart';
import 'package:todo_list/data/todo_item_model.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';

class AddTodoItem extends StatefulWidget {
  const AddTodoItem({Key? key}) : super(key: key);

  @override
  _AddTodoItemState createState() => _AddTodoItemState();
}

class _AddTodoItemState extends State<AddTodoItem> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController task = TextEditingController();
  final TextEditingController description = TextEditingController();

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
                  padding: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                    textAlign: TextAlign.center,
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
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          if(_formKey.currentState!.validate()){
                            DatabaseHelper.addTodoItem(
                                TodoItem(
                                    title: title.text,
                                    task: task.text,
                                    description: description.text,
                                    completed: false
                                )
                            );
                            BlocProvider.of<TodoCubit>(context).reset();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "SUBMIT",
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
                    ],
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
