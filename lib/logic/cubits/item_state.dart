part of 'item_cubit.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class ItemInitial extends ItemState {
  @override
  List<Object> get props => [];
}

class ItemChanged extends ItemState{
  @override
  List<Object?> get props => [];

}
