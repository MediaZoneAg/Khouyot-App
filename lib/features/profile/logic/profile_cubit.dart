import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/db/cached_app.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/profile/data/models/change_password_model.dart';
import 'package:khouyot/features/profile/data/models/edit_profile_model.dart';
import 'package:khouyot/features/profile/data/models/edit_profile_response.dart';
import 'package:khouyot/features/profile/data/models/profile_model.dart';
import 'package:khouyot/features/profile/data/repos/profile_repo.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo; // Declare an instance variable
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileModel? profileModel;


  bool isObscureText1 = true;
  String selectedCountry = "Select Country";

  // Added getToken method
    getToken(){
    return CashHelper.getString(key: Keys.token);
  }
  void obscureText1() {
    isObscureText1 = !isObscureText1;
    emit(ObscureText1());
  }

  void updateSelectedCountry(String country) {
    selectedCountry = country;
    emit(CountrySelected(country));
  }

  Future<void> fetchProfile() async {
    try {
      profileModel = CachedApp.getCachedData(CachedDataType.profile.name);
      emit(ProfileSuccess());
    }catch(e){
        emit(ProfileLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await profileRepo.getProfile();
      response.fold((error) {
        emit(ProfileFailure(error));
        profileModel = null;
      }, (profileData) {
        profileModel = profileData;
        CachedApp.saveData(profileModel,CachedDataType.profile.name);
        emit(ProfileSuccess());
      });
      return;
    } else {
      profileModel = null;
      Fluttertoast.showToast(
            msg: "No internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorsManager.kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
      emit(ProfileFailure(ApiErrorModel(message: 'No internet connection')));
      }
    }
  }

  Future<void> deletUserAccount() async {
    emit(DeleteAccountLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await profileRepo.deletAccount();
      response.fold((error) {
        emit(DeleteAccountFailure(error));
      }, (profileData) {
        emit(DeleteAccountSuccess('Account deleted successfully'));
      });
      return;
    } else {
      emit(DeleteAccountFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> editProfile(EditProfileModel editProfileModel) async {
    emit(EditProfileLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response =
          await profileRepo.featchProfileNew(editProfile: editProfileModel);
      response.fold((l) => emit(EditProfileFailure(l)), (r) {
        emit(EditProfileSuccess(editProfileResponse: r));
      });
    } else {
      emit(
          EditProfileFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> changePassword(ChangePaswwordModel changePaswwordModel) async {
    emit(ChangePasswordLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await profileRepo.changePassword(
          changePaswwordModel: changePaswwordModel);
      response.fold((l) => emit(ChangePasswordFailure(l)), (r) {
        emit(ChangePasswordSuccess());
      });
    } else {
      emit(ChangePasswordFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }
}
