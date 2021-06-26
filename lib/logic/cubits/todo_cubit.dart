import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/data/database_helper.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  getTodoList() async{
    try{
      var todoList = await DatabaseHelper.fetchTodoList();
      emit(TodoLoaded(todoList));
    }catch(e){
      emit(TodoError(e.toString()));
    }
  }

  reset(){
    emit(TodoInitial());
  }

}
