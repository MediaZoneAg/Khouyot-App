part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ObscureText1 extends AuthState {}

final class ObscureText2 extends AuthState {}

final class ChangeCheckboxValue extends AuthState {}

class PasswordValidationState extends AuthState {}

class SignupPasswordFocusChanged extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignInSuccess extends AuthState {
  final SignInResponse signInResponse;
  SignInSuccess({required this.signInResponse});
}

final class SignUpSuccess extends AuthState {
  final SignUpResponse signUpResponse;
  SignUpSuccess({required this.signUpResponse});
}

final class SignInFailure extends AuthState {
  final ApiErrorModel error;

  SignInFailure( this.error);
}

final class SignUpFailure extends AuthState {
  final ApiErrorModel error;

  SignUpFailure( this.error);
}

final class ForgetPasswordLoading extends AuthState {}

final class ForgetPasswordSuccess extends AuthState {}

final class ForgetPasswordFailure extends AuthState {
  final ApiErrorModel error;

  ForgetPasswordFailure( this.error);
}

final class ResendCodeLoading extends AuthState {}

final class ResendCodeSuccess extends AuthState {}

final class ResendCodeFailure extends AuthState {
  final ApiErrorModel error;

  ResendCodeFailure( this.error);
}

final class OtpLoading extends AuthState {}

final class OtpSuccess extends AuthState {}

final class OtpFailure extends AuthState {
  final ApiErrorModel error;

  OtpFailure( this.error);
}

final class ResetPasswordLoading extends AuthState {}

final class  ResetPasswordSuccess extends AuthState {}

final class  ResetPasswordFailure extends AuthState {
  final ApiErrorModel error;

  ResetPasswordFailure( this.error);
}