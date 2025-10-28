part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ObscureText1 extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
}

final class ProfileFailure extends ProfileState {
  final ApiErrorModel error;
  ProfileFailure(this.error);
}

final class CountrySelected extends ProfileState {
  final String country;
  CountrySelected(this.country);
}

final class DeleteAccountLoading extends ProfileState {}

final class  DeleteAccountSuccess extends ProfileState {
  final String message;
  DeleteAccountSuccess(this.message);
}

final class  DeleteAccountFailure extends ProfileState {
  final ApiErrorModel error;
  DeleteAccountFailure(this.error);
}

final class EditProfileLoading extends ProfileState {}

final class EditProfileSuccess extends ProfileState {
  final  EditProfileResponse editProfileResponse;
  EditProfileSuccess({required this.editProfileResponse});
}

final class EditProfileFailure extends ProfileState {
  final ApiErrorModel error;
  EditProfileFailure( this.error);
}

// final class AddToWishListLoading extends ProfileState {}

// final class AddToWishListSuccess extends ProfileState {}

// final class AddToWishListFailure extends ProfileState {
//   final ApiErrorModel error;
//   AddToWishListFailure( this.error);
// }

// final class GetWishListLoading extends ProfileState {}

// final class GetWishListSuccess extends ProfileState {}

// final class GetWishListFailure extends ProfileState {
//   final ApiErrorModel error;
//   GetWishListFailure( this.error);
// }

// final class RemoveFromWishListLoading extends ProfileState {}

// final class RemoveFromWishListSuccess extends ProfileState {}

// final class RemoveFromWishListFailure extends ProfileState {
//   final ApiErrorModel error;
//   RemoveFromWishListFailure( this.error);
// }

final class ChangePasswordLoading extends ProfileState {}

final class ChangePasswordSuccess extends ProfileState {}

final class ChangePasswordFailure extends ProfileState {
  final ApiErrorModel error;
  ChangePasswordFailure( this.error);
}