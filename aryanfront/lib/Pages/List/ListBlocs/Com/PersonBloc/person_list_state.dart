part of 'person_list_bloc.dart';

@immutable
sealed class PersonlistState {}

final class PersonlistInitial extends PersonlistState {}


class LoadDataLoading extends PersonlistState {

}

class LoadDataSuccess extends PersonlistState {

}

class LoadDataError extends PersonlistState {

}
class LoadDataSendListDatas extends PersonlistState {

  final List<ResponseData> data;
  LoadDataSendListDatas(this.data);
}


class FilterDataLoading extends PersonlistState {

}

class FilterDataSuccess extends PersonlistState {

}

class FilterDataError extends PersonlistState {

}


class SortDataLoading extends PersonlistState {

}

class SortDataSuccess extends PersonlistState {

}

class SortDataError extends PersonlistState {

}


class PaginationDataLoading extends PersonlistState {

}

class PaginationDataSuccess extends PersonlistState {

}

class PaginationDataError extends PersonlistState {

}