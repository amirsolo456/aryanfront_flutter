import '../../Models/Data/Auth/User/dto.dart';

abstract class IUserExistService {
  Future<Response?> CheckIfExist(Request request);
}
