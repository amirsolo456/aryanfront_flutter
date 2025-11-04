part of 'person_list_bloc.dart';

@immutable
sealed class PersonlistEvent {}

class LoadDataEvent extends PersonlistEvent{

}

class FilterDataEvent extends PersonlistEvent{

}

class SortDataEvent extends PersonlistEvent{

}

class PaginationDataEvent extends PersonlistEvent{

}