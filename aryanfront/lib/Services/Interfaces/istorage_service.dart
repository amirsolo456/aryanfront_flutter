import '../../Models/Data/Auth/User/dto.dart';

abstract class IStorage {
  Future<void> setUser(UserDto? user);
  Future<UserDto?> getUser();

  Future<void> setToken(String token);
  Future<String?> getToken();

  Future<void> clearAll();
  Future<String?> getDeviceToken();
}
