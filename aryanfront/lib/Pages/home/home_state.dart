part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class GetContactsDataLoading  extends HomeState{

}

class GetContactsDataSuccess  extends HomeState{

}

class GetContactsDataError  extends HomeState{

}

// Crud On GetContactsDataLoading
class DeleteContactLoading  extends HomeState{

}

class UpdateContactLoading  extends HomeState{

}

class InsertContactLoading  extends HomeState{

}