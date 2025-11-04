import 'package:aryanfront/Classes/Models/Data/Com/Person/dto.dart'
    show ResponseData, Response;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../Classes/Models/Base/base_response.dart';
import '../../../../../Classes/Services/Base/api_client.dart';

part 'person_list_event.dart';
part 'person_list_state.dart';

class PersonListBloc extends Bloc<PersonlistEvent, PersonlistState> {
  final ApiClient apiClient;

  PersonListBloc({required this.apiClient}) : super(LoadDataLoading()) {
    on<PersonlistEvent>((event, emit) async {
      if (event is LoadDataEvent) {
        try {
          emit(LoadDataLoading());
          final response = await apiClient
              .sendRequestAsync<ResponseData, List<ResponseData>>(
                '/persons', // endpoint
                HttpMethods.get, // GET request
                null, // no body
                false, // token not needed
                Exception('خطا در دریافت اطلاعات'),
                (json) {
                  // تبدیل JSON به لیست Person
                  final BaseResponse<ResponseData> list = json['data'] ?? [];
                  final persons = list.map((e) => Person.fromJson(e)).toList();
                  return BaseResponse<List<Person>>(data: persons);
                },
              );

          emit(LoadDataSuccess());
        } catch (e) {
          emit(LoadDataError());
        } finally {
          // ایجاد یک لیست فیک از ResponseData
          final fakeData = [
            ResponseData(
              personId: 1,
              fullName: "امیر سلیمانی",
              fatherName: "یاسر",
              nationalCode: "1234567890",
              isForeign: false,
            ),
            ResponseData(
              personId: 2,
              fullName: "فاطمه رضایی",
              fatherName: "علی",
              nationalCode: "0987654321",
              isForeign: false,
            ),
            ResponseData(
              personId: 3,
              fullName: "محمد احمدی",
              fatherName: "حسین",
              nationalCode: "1122334455",
              isForeign: true,
            ),
          ];

          emit(LoadDataSendListDatas(fakeData));
        }
      } else if (event is FilterDataEvent) {
        try {
          emit(FilterDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(FilterDataSuccess());
        } catch (e) {
          emit(FilterDataError());
        }
      } else if (event is SortDataEvent) {
        try {
          emit(SortDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(SortDataSuccess());
        } catch (e) {
          emit(SortDataError());
        }
      } else if (event is PaginationDataEvent) {
        try {
          emit(PaginationDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(PaginationDataSuccess());
        } catch (e) {
          emit(PaginationDataError());
        }
      } else {}
    });
  }
}
