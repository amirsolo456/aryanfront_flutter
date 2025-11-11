import '../../Models/Data/Auth/User/dto.dart';

abstract class IStorageService {
  Future<void> setUser(UserDto? user);
  Future<UserDto?> getUser();

  Future<void> setToken(String token);
  Future<String?> getToken();

  Future<void> clearAll();
  Future<void> setDeviceToken(String token);
  Future<String?> getDeviceToken();
}
