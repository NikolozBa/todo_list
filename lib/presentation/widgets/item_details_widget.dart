import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/data/database_helper.dart';
import 'package:todo_list/logic/cubits/item_cubit.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';
import 'package:todo_list/presentation/widgets/edit_item_widget.dart';

class TodoItemDetails extends StatelessWidget {
  final QueryDocumentSnapshot todoItem;

  const TodoItemDetails({Key? key, required this.todoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _val = todoItem["completed"];
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.06),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  todoItem["title"],
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  todoItem["task"],
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "description:",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  todoItem["description"],
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocConsumer<ItemCubit, ItemState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ItemInitial) {
                        return TextButton(
                          onPressed: () {
                            _val = !_val;
                            DatabaseHelper.updateTodoItemCompleted(todoItem.id, _val);
                            BlocProvider.of<TodoCubit>(context).getTodoList();
                            BlocProvider.of<ItemCubit>(context).change();
                          },
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check,
                                size: width*0.08,
                                color: Colors.white,
                              ),
                              Text(
                                "DONE",
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size(width*0.23, width*0.23),
                            backgroundColor:
                                _val ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                        );
                      } else {
                        return TextButton(
                          onPressed: () {
                            _val = !_val;
                            DatabaseHelper.updateTodoItemCompleted(todoItem.id, _val);
                            BlocProvider.of<TodoCubit>(context).getTodoList();
                            BlocProvider.of<ItemCubit>(context).initial();
                          },
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check,
                                size: width*0.08,
                                color: Colors.white,
                              ),
                              Text(
                                "DONE",
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          style: TextButton.styleFrom(
                            minimumSize: Size(width*0.23, width*0.23),
                            backgroundColor:
                                _val ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return EditTodoItem(todoItem: todoItem);
                          });
                    },
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.mode_edit,
                          size: width*0.08,
                          color: Colors.white,
                        ),
                        Text(
                          "EDIT",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size(width*0.23, width*0.23),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("Delete this item?"),
                          content:
                              Text("Do you really want to delete this item?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                DatabaseHelper.deleteTodoItem(todoItem.id);
                                Navigator.pop(context);
                                BlocProvider.of<TodoCubit>(context).reset();
                                Navigator.pop(context);
                              },
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.delete,
                          size: width*0.08,
                          color: Colors.white,
                        ),
                        Text(
                          "EDIT",
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: Size(width*0.23, width*0.23),
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // tavidan ise mqonda gaketebuli rom "submit"-is dacheris gareshe ar aketebda update-s.
                      //
                      //
                      // DatabaseHelper.updateTodoItemCompleted(
                      //     todoItem.id, _val);
                      // BlocProvider.of<TodoCubit>(context).getTodoList();
                      Navigator.pop(context);
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
    );
  }
}
