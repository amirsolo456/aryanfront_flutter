import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aryanfront/Classes/Framework/safe_exquter.dart';
import 'package:aryanfront/Classes/Models/Base/base_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../Models/Base/base_request.dart' show BaseRequest, Defaults;



abstract interface class IApiClient {
  Future<T> sendRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
    required FromJson<T> fromJson,
  );

  Future<T>
  sendHyperRequestAsync<T extends BaseResponse<D>, D, C extends BaseRequest>(
    String url,
    HttpMethods method,
    C? data,
    bool? setToken,
    Exception? fallbackMessage,
    required FromJson<T> fromJson,
  );
}

class ApiClient extends IApiClient {


  final IStorage storage;
  final IExceptionNotifier notifier;
  final ApiSettings appSettings;
  typedef FromJson<T> = T Function(Map<String, dynamic> json);
  @override
  Future<T> sendRequestAsync<T extends BaseResponse<D>, D>(
    String url,
    HttpMethods method,
    Object? data,
    bool? setToken,
    Exception? fallbackMessage,
  ) async {
    final T finalReslt =
        BaseResponse<D>.error(new Exception('خطایی رخ داده است')) as T;
    http.Response response;

    try {


      final executor = SafeExqueter<bool>.fromString(
        baseUrl,
        errorMessage: "Base URL خالیه",
      );
      final bool isValid = await executor.execute((val) async {
        return val != null && val.isNotEmpty;
      });
      if (!isValid) {
        finalReslt.exception = Exception("Base URL invalid");
        return finalReslt;
      }

      final Uri uri = Uri.https(baseUrl != null ? '$baseUrl$url' : 'Null');
      final client = RetryClient(http.Client());
      final headers = <String, String>{'Content-Type': 'application/json'};
      final bool useToken = setToken ?? false;

      if (useToken) {
        final token = await GetToken();
        bool hasToken = await executor.execute((token) async {
          return token != null && token.isNotEmpty;
        });
        if (hasToken == false) {
          finalReslt.exception = Exception("Token invalid");
          return finalReslt;
        }

        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }

      bool Httpmothod = await executor.execute((method) async {
        return method != null && method != HttpMethods.unknown;
      });
      if (Httpmothod == false) {
        finalReslt.exception = Exception("Methos Is invalid");
        return finalReslt;
      }

      switch (method.prefix) {
        case 'Get':
          response = await client.get(uri, headers: headers);
          break;
        case 'Post':
          response = await client.post(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Put":
          response = await client.put(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Delete":
          response = await client.delete(uri, headers: headers);
          break;
        default:
          finalReslt.exception = Exception('Unsupported HTTP method');
          return finalReslt;
          break;
      }
      return await json.decode(response.body) as T;
    } catch (e) {
      return BaseResponse<D>.error(e is Exception ? e : Exception(e.toString()))
          as T;
    }
  }

  // ------------------------- Core SendRequest -------------------------
  Future<T?>
  sendHyperRequestAsync<T extends BaseResponse<D>, D, C extends BaseRequest>(
    String url,
    HttpMethods method,
    C? data,
    bool? setToken,
    Exception? fallbackMessage,
    required FromJson<T> fromJson,
  ) async {
    final T finalReslt =
        BaseResponse<D>.error(new Exception('خطایی رخ داده است')) as T;
    http.Response response;

    try {

      if (data != null) {
        data.defaults = appSettings.appDefaults;
      }

      final executor = SafeExqueter<bool>.fromString(
        baseUrl,
        errorMessage: "Base URL خالیه",
      );

      final bool isValid = await executor.execute((val) async {
        return val != null && val.isNotEmpty;
      });

      final bool isLogin = await executor.execute((baseUrl) async {
        return baseUrl.toString().contains('Login');
      });

      if (isLogin == false) {
      } else {
        final token = await GetToken();
        bool hasToken = await executor.execute((token) async {
          return token != null && token.isNotEmpty;
        });
        if (hasToken == false) {
          finalReslt.exception = Exception("Token invalid");
          return finalReslt;
        }

        // Internal request
        final result = await _internalSendRequest<T, D>(
          url: url,
          method: method,
          data: data,
          token: token,
          fromJson: fromJson,
        );

        // اگر خطا یا Pending
        if (result != null &&
            (result.result == "Failed" || result.result == "Pending") &&
            (result.error == null || result.error!.isEmpty)) {
          await _exceptionHandler(fallbackMessage ?? Exception("خطا"));
        }

        return result;
      }

      final Uri uri = Uri.https(baseUrl != null ? '$baseUrl$url' : 'Null');
      final client = RetryClient(http.Client());
      final headers = <String, String>{'Content-Type': 'application/json'};
      final bool useToken = setToken ?? false;

      if (useToken) {
        headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      }

      bool Httpmothod = await executor.execute((method) async {
        return method != null && method != HttpMethods.unknown;
      });
      if (Httpmothod == false) {
        finalReslt.exception = Exception("Methos Is invalid");
        return finalReslt;
      }

      switch (method.prefix) {
        case 'Get':
          response = await client.get(uri, headers: headers);
          break;
        case 'Post':
          response = await client.post(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Put":
          response = await client.put(
            uri,
            headers: headers,
            body: data?.toString(),
          );
          break;
        case "Delete":
          response = await client.delete(uri, headers: headers);
          break;
        default:
          finalReslt.exception = Exception('Unsupported HTTP method');
          return finalReslt;
          break;
      }
      return await json.decode(response.body) as T;
    } catch (e) {
      return BaseResponse<D>.error(e is Exception ? e : Exception(e.toString()))
          as T;
    }
  }

  // ------------------------- InternalSendRequest -------------------------
  Future<T?> _internalSendRequest<T extends BaseResponse<D>, D>({
    required String url,
    required HttpMethod method,
    Object? data,
    String? token,
    required FromJson<T> fromJson,
  }) async {
    try {
      final uri = Uri.parse('${appSettings.baseUrl}$url');
      final client = RetryClient(http.Client(), retries: 2);
      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) HttpHeaders.authorizationHeader: 'Bearer $token',
      };

      http.Response response;

      final body = data != null ? jsonEncode(data) : null;

      switch (method) {
        case HttpMethod.get:
          response = await client.get(uri, headers: headers);
          break;
        case HttpMethod.post:
          response = await client.post(uri, headers: headers, body: body);
          break;
        case HttpMethod.put:
          response = await client.put(uri, headers: headers, body: body);
          break;
        case HttpMethod.delete:
          response = await client.delete(uri, headers: headers);
          break;
      }

      if (response.statusCode == 401) {
        // Unauthorized → queue request & refresh token
        final tcs = Completer<T?>();
        _pendingRequests.add(() async {
          final r = await _internalSendRequest<T, D>(
              url: url, method: method, data: data, token: token, fromJson: fromJson);
          tcs.complete(r);
        });
        final refreshed = await _refreshToken();
        if (!refreshed) {
          await _exceptionHandler(Exception("Unauthorized"), context: "401");
          tcs.complete(null);
        }
        return tcs.future;
      }

      await _exceptionHandlerHttpStatus(response.statusCode);

      final responseData = response.body;
      if (responseData.trimLeft().startsWith('{') || responseData.trimLeft().startsWith('[')) {
        return fromJson(jsonDecode(responseData));
      } else {
        notifier.raise(Exception("پاسخ نامعتبر از سرور: $responseData"));
        return null;
      }
    } catch (e) {
      await _exceptionHandler(e is Exception ? e : Exception(e.toString()));
      return null;
    }
  }

  // ------------------------- Exception Handling -------------------------
  Future<void> _exceptionHandler(dynamic ex, {String? context}) async {
    if (ex is Exception) {
      notifier.raise(ex, context: context);
    } else {
      notifier.raise(Exception(ex.toString()), context: context);
    }
  }

  Future<void> _exceptionHandlerHttpStatus(int statusCode) async {
    switch (statusCode) {
      case 401:
        notifier.raise(Exception("توکن منقضی شده"), context: "401");
        break;
      case 500:
        notifier.raise(Exception("خطا در اتصال یا پاسخ نامعتبر از سرور"), context: "500");
        break;
      case 408:
        notifier.raise(Exception("درخواست منقضی شد (Timeout)"));
        break;
      case 502:
        notifier.raise(Exception("خطا در پردازش داده‌ها"));
        break;
      default:
        break;
    }
  }
}






// ------------------------- Supporting Types -------------------------
enum HttpMethod { get, post, put, delete }
enum HttpMethods {
  get(1, 'Get'),
  post(2, 'Post'),
  put(3, 'Put'),
  delete(4, 'Delete'),
  unknown(-1, 'Unknown');

  final String prefix;
  final int priority;

  const HttpMethods(this.priority, this.prefix);
}

Future<String> GetToken() async {
  return 'a';
}

String baseUrl = '';
abstract class IStorage {
  Future<Dto?> getUser();
  Future<String?> getDeviceToken();
  Future<void> setUser(Dto user);
  Future<void> setToken(String token);
}

abstract class IExceptionNotifier {
  void raise(Exception ex, {String? context});
}

class ApiSettings {
  final String baseUrl;
  final String loginUrl;
  final Defaults appDefaults;

  ApiSettings({required this.baseUrl, required this.loginUrl, required this.appDefaults});
}

// Example DTO
class Dto {
  String token;
  String refreshToken;

  Dto({required this.token, required this.refreshToken});
}