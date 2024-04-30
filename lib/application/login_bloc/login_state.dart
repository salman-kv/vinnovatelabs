abstract class LoginState{}

class InitialLoginState extends LoginState{}
class SplashScreenUserAlredyLoginedState extends LoginState{}
class LoginLoadingState extends LoginState{}
class SplashScreenUserNotLoginedState extends LoginState{}
class OtpSendLoadingState extends LoginState{}
class OtpVerificationCodeSentState extends LoginState{
  final String verificationId;

  OtpVerificationCodeSentState({required this.verificationId});
}
class OtpverificationSuccessState extends LoginState{}
class OtpverificationFailedState extends LoginState{}
class ApiErrorState extends LoginState{}
class SearchSuccessState extends LoginState{}

