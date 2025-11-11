import '../../Models/Data/Auth/Otp/dto.dart';

abstract class IOtpService {
  Future<Response?> sendOtp(Request request);
  Future<Response?> validateOtp(Request request);
}
