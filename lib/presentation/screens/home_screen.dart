import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:todo_list/data/database_helper.dart';
import 'package:todo_list/logic/cubits/todo_cubit.dart';
import 'package:todo_list/presentation/widgets/add_item_widget.dart';
import 'package:todo_list/presentation/widgets/item_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late final Animation _listAnimation;
  late Animation _titleAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _listAnimation = Tween<Offset>(begin: Offset(0,1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));
    _titleAnimation = Tween(begin: 0.0, end: 33.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Timer(Duration(milliseconds: 300),()=>_controller.forward()); // animaciis kargad gamosachenad
    _controller.addListener(() {setState(() {

    });});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.04),
                      child: Text(
                        "TODO APP",
                        style: GoogleFonts.lato(
                            color: Colors.blueGrey,
                            fontSize: _titleAnimation.value,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.08),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColorDark,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(8),
                        ),
                        child: Icon(Icons.add),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return AddTodoItem();
                              });
                        },
                      ),
                    )
                  ],
                )),
            Expanded(
              flex: 11,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20, left: width * 0.1, right: width * 0.1),
                  child: BlocConsumer<TodoCubit, TodoState>(
                    listener: (context, state) {
                      if (state is TodoError) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("ERROR"),
                            content: Text(state.errorMessage),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  return Navigator.pop(context);
                                },
                                child: Text("OK"),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is TodoInitial) {
                        BlocProvider.of<TodoCubit>(context).getTodoList();
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TodoLoaded) {
                        return SlideTransition(
                          //position: _listAnimation  ??? ar mushaobs
                          position: Tween<Offset>(begin: Offset(0,1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad)),
                          child: ListView.builder(
                            itemCount: state.todoList.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot todoItem =
                                  state.todoList.docs[index];

                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TodoItemDetails(
                                            todoItem: todoItem);
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(13.0)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width*0.04),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: 13),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      todoItem["title"],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 24),
                                                    ),
                                                    Text(
                                                      todoItem["task"],
                                                      style: GoogleFonts.lato(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width*0.04,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              DatabaseHelper
                                                  .updateTodoItemCompleted(
                                                      todoItem.id,
                                                      !todoItem["completed"]);
                                              BlocProvider.of<TodoCubit>(context)
                                                  .getTodoList();
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              child: Icon(
                                                Icons.check,
                                                size: 35,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: todoItem["completed"]
                                                      ? Theme.of(context).accentColor
                                                      : Color(0xffc9c9c9),
                                                  shape: BoxShape.circle
                                                  //shape:
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else
                        return Container();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
