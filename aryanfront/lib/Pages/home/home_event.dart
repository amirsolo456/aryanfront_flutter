part of 'home_bloc.dart';


@immutable
sealed class HomeEvent {}

class GetContactsDataEvent extends HomeEvent{

}

class CrudContactsDataEvent extends HomeEvent{

}