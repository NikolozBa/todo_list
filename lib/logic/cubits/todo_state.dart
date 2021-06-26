part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState{
  final QuerySnapshot todoList;

  TodoLoaded(this.todoList);

  @override
  List<Object?> get props => [todoList];

}


class TodoError extends TodoState{
  final String errorMessage;

  TodoError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

}