// -------------------- Api Middleware --------------------
import '../../Models/Data/Com/Person/dto.dart';
import '../api_client_service.dart';
import 'fake_data_service.dart';

class ApiClientMiddlewareService {
  final ApiClient apiClient;

  ApiClientMiddlewareService({required this.apiClient});

  Future<Response> sendRequestWithFallback(
    String url,
    HttpMethods method, {
    Request? request,
    bool setToken = false,
  }) async {
    if (apiClient.appSettings.baseUrl.isEmpty ||
        apiClient.appSettings.baseUrl == '') {
      await Future.delayed(Duration(seconds: 2));
      return FakeDataService.getFakePersons();
    }

    final response = await apiClient
        .sendRequestAsync<Response, ResponseData, Request>(
          url,
          method,
          request ?? Request(),
          setToken,
          Exception("خطا در دریافت اطلاعات"),
        );

    // اگر null برگشت، می‌توان فیک دیتا برگرداند
    return response ?? FakeDataService.getFakePersons();
  }
}
