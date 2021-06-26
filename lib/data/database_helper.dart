import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/data/todo_item_model.dart';


final CollectionReference users = FirebaseFirestore.instance.collection("users");


class DatabaseHelper{
  static String? username;

  static Future<void> addTodoItem(TodoItem data) async{
    await users.doc(username).collection("todo_list").doc().set(data.toJson());
  }

  static Future<QuerySnapshot> fetchTodoList() async{
    return users.doc(username).collection("todo_list").get();
  }

  static Future<void> deleteTodoItem(String id) async{
    users.doc(username).collection("todo_list").doc(id).delete();
  }

  static Future<void> updateTodoItem({String? id, TodoItem? data}) async{
    users.doc(username).collection("todo_list").doc(id).update(
        data!.toJson()
    );
  }

  static Future<void> updateTodoItemCompleted(String? id, bool value) async{
    users.doc(username).collection("todo_list").doc(id).update({
      "completed": value,
    });
  }

}