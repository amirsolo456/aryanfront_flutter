import 'package:aryanfront/Classes/Services/Base/api_client.dart';

class SafeExqueter<T> {
  final dynamic value;
  final String errorMessage;

  SafeExqueter.fromString(String? value, {this.errorMessage = "Invalid string"})
    : value = value;

  SafeExqueter.fromBool(bool? value, {this.errorMessage = "Invalid bool"})
    : value = value;

  SafeExqueter.fromInt(int? value, {this.errorMessage = "Invalid int"})
    : value = value;

  SafeExqueter.fromHttpMethods(
    HttpMethods? value, {
    this.errorMessage = "Invalid HttpMethod",
  }) : value = value;

  /// اجرای ایمن عملیات
  Future<T> execute(Future<T> Function(dynamic value) action) async {
    try {
      if (value == null) {
        print("Error: $errorMessage");
        // اگر خروجی جنریک T باید false باشه:
        if (T == bool) return false as T;
        throw Exception(errorMessage);
      }
      return await action(value);
    } catch (e) {
      print("Error during execution: $e");
      if (T == bool) return false as T;
      rethrow;
    }
  }
}
