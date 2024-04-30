abstract class LoginEvent{}

class SplashScreenLoginEvent extends LoginEvent{}
class SignInOtpSendEvent extends LoginEvent{
  final String phoneNumber;

  SignInOtpSendEvent({required this.phoneNumber});
}
class SignInOtpSendedEvent extends LoginEvent{
  final String verificationId;

  SignInOtpSendedEvent({required this.verificationId});
}
class OtpVerificationEvent extends LoginEvent{
  final String otp;
  final String verificationId;

  OtpVerificationEvent({required this.otp, required this.verificationId});
}
class LogoutEvent extends LoginEvent{
}
class SearchingEvent extends LoginEvent{
  final String text;

  SearchingEvent({required this.text});
}
class CancelSearchEvent extends LoginEvent{}