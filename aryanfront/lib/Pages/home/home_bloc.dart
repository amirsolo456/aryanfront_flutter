import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if (event is GetContactsDataEvent) {
        emit(GetContactsDataLoading());
        try {
          emit(GetContactsDataSuccess());
        } catch (e) {
          emit(GetContactsDataError());
        }
      } else if (event is CrudContactsDataEvent) {
        emit(DeleteContactLoading());
        try {
          emit(UpdateContactLoading());
        } catch (e) {
          emit(InsertContactLoading());
        }
      }
    });
  }
}
