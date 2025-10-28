
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/features/auth/data/models/otp_model.dart';
import 'package:khouyot/features/auth/data/models/reset_password_model.dart';
import 'package:khouyot/features/auth/data/models/sign_in_model.dart';
import 'package:khouyot/features/auth/data/models/sign_in_response.dart';
import 'package:khouyot/features/auth/data/models/sign_up_model.dart';
import 'package:khouyot/features/auth/data/models/sign_up_response.dart';
import 'package:khouyot/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  static AuthCubit get(context) => BlocProvider.of(context);

  bool isObscureText1 = true;
  bool isObscureText2 = true;
  bool? isChecked = false;
  int index = 0;
  bool isPasswordValid = false;
  bool showPasswordValidator = false;

  void setPasswordValidationStatus(bool isValid) {
    isPasswordValid = isValid;
    emit(PasswordValidationState());
  }
  void togglePasswordValidator(bool isFocused) {
    showPasswordValidator = isFocused;
    emit(SignupPasswordFocusChanged());
  }

  void obscureText1() {
    isObscureText1 = !isObscureText1;
    emit(ObscureText1());
  }

  void obscureText2() {
    isObscureText2 = !isObscureText2;
    emit(ObscureText2());
  }


  void changeCheckboxValue(bool newIsChecked) {
    isChecked = newIsChecked;
    emit(ChangeCheckboxValue());
  }

  Future<void> signIn(SignInModel signInModel) async {
    emit(SignInLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.signIn(signIn: signInModel);
      response.fold(
        (l) => emit(SignInFailure(l)),
        (r) {
          // Save sign-in response securely
          CashHelper.setStringSecured(
            key: Keys.signInResponse,
            value: r.toJson(),
          );
          CashHelper.setStringSecured(
            key: Keys.token,
            value: r.token!,
          );
          emit(SignInSuccess(signInResponse: r));
        },
      );
    } else {
      // translate the message pls
      emit(SignInFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> signUp(SignUpModel signUpModel) async {
    emit(SignUpLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.signUp(signUp: signUpModel);
      response.fold(
        (l) => emit(SignUpFailure( l )),
        (r) {
          // Save sign-in response securely
          CashHelper.setStringSecured(
            key: Keys.signUpResponse,
            value: r.toJson(),
          );
          CashHelper.setStringSecured(
            key: Keys.token,
            value: r.token!,
          );
          emit(SignUpSuccess(signUpResponse: r));
        },
      );
    } else {
      // translate the message pls
      emit(SignUpFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  void focusNextField(BuildContext context) {
  if (index < 5) { // Update to 3 since the last index is 3 for 4 fields
    index++;
    FocusScope.of(context).nextFocus();
  }
}

void focusPreviousField(BuildContext context) {
  if (index > 0) {
    index--;
    FocusScope.of(context).previousFocus();
  }
}

void clearOtpFields(List<TextEditingController> otpControllers) {
  for (var controller in otpControllers) {
    controller.clear(); // Clear the text field
  }
  index = 0; // Reset index to the first field
}

Future<void> forgetPaswword(String email) async {
    emit(ForgetPasswordLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.forgetpassword(email: email);
      response.fold(
        (l) => emit(ForgetPasswordFailure( l )),
        (r)  {
          emit(ForgetPasswordSuccess());
        }
      );
    } else {
      emit(ForgetPasswordFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> resendCode(String email) async {
    emit(ResendCodeLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.resendCode(email: email);
      response.fold(
        (l) => emit(ResendCodeFailure( l )),
        (r)  {
          emit(ResendCodeSuccess());
        }
      );
    } else {
      emit(ResendCodeFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> otp(OtpModel otpModel) async {
    emit(OtpLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.otp(otpModel: otpModel);
      response.fold(
        (l) => emit(OtpFailure( l )),
        (r)  {
        CashHelper.setStringSecured(
          key: Keys.secretKey,
          value: r.secretKey!,
        );
          emit(OtpSuccess());
        }
      );
    } else {
      emit(OtpFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> resetPassword(ResetPasswordModel resetPasswordModel) async {
    emit(ResetPasswordLoading());
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await authRepo.resetPssword(resetPasswordModel: resetPasswordModel);
      response.fold(
        (l) => emit(ResetPasswordFailure( l )),
        (r)  {
          emit(ResetPasswordSuccess());
        }
      );
    } else {
      emit(ResetPasswordFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }
}
