// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Fill your information below or register with your social account`
  String get SignUpDes {
    return Intl.message(
      'Fill your information below or register with your social account',
      name: 'SignUpDes',
      desc: '',
      args: [],
    );
  }

  /// `Hello Welcome back you’ve been missed`
  String get SignInDes {
    return Intl.message(
      'Hello Welcome back you’ve been missed',
      name: 'SignInDes',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get Email {
    return Intl.message(
      'E-mail',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get confirmLogout {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `You want to log out?`
  String get youWantTologout {
    return Intl.message(
      'You want to log out?',
      name: 'youWantTologout',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get Enteryouremail {
    return Intl.message(
      'Enter your email',
      name: 'Enteryouremail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Full Name`
  String get EnterYourFullName {
    return Intl.message(
      'Enter Your Full Name',
      name: 'EnterYourFullName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `phone can not be empty`
  String get phonecannotbeempty {
    return Intl.message(
      'phone can not be empty',
      name: 'phonecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `invalid phone number`
  String get invalidphonenumber {
    return Intl.message(
      'invalid phone number',
      name: 'invalidphonenumber',
      desc: '',
      args: [],
    );
  }

  /// `invalid floor number`
  String get invalidFloornumber {
    return Intl.message(
      'invalid floor number',
      name: 'invalidFloornumber',
      desc: '',
      args: [],
    );
  }

  /// `invalid address`
  String get invalidAdress {
    return Intl.message(
      'invalid address',
      name: 'invalidAdress',
      desc: '',
      args: [],
    );
  }

  /// `Name can not be empty`
  String get Namecannotbeempty {
    return Intl.message(
      'Name can not be empty',
      name: 'Namecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `City can not be empty`
  String get Citycannotbeempty {
    return Intl.message(
      'City can not be empty',
      name: 'Citycannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `invalid City`
  String get invalidCity {
    return Intl.message(
      'invalid City',
      name: 'invalidCity',
      desc: '',
      args: [],
    );
  }

  /// `please fill all fields`
  String get pleaseFillAllFields {
    return Intl.message(
      'please fill all fields',
      name: 'pleaseFillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `address can not be empty`
  String get addresscannotbeempty {
    return Intl.message(
      'address can not be empty',
      name: 'addresscannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `floor can not be empty`
  String get floorcannotbeempty {
    return Intl.message(
      'floor can not be empty',
      name: 'floorcannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get Enteryourpassword {
    return Intl.message(
      'Enter your password',
      name: 'Enteryourpassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get Enteryourname {
    return Intl.message(
      'Enter your name',
      name: 'Enteryourname',
      desc: '',
      args: [],
    );
  }

  /// `Agree with  `
  String get Agreewith {
    return Intl.message(
      'Agree with  ',
      name: 'Agreewith',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Terms&Conditions' key

  /// `Or sign in with`
  String get Orsigninwith {
    return Intl.message(
      'Or sign in with',
      name: 'Orsigninwith',
      desc: '',
      args: [],
    );
  }

  /// `Or sign up with`
  String get Orsignupwith {
    return Intl.message(
      'Or sign up with',
      name: 'Orsignupwith',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?  `
  String get Alreadyhaveanaccount {
    return Intl.message(
      'Already have an account ?  ',
      name: 'Alreadyhaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password `
  String get Forgotpassword {
    return Intl.message(
      'Forgot password ',
      name: 'Forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// ` Don’t have an account?  `
  String get Donthaveanaccount {
    return Intl.message(
      ' Don’t have an account?  ',
      name: 'Donthaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifycodeword {
    return Intl.message(
      'Verify Code',
      name: 'verifycodeword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code we just sent to email`
  String get VerifyCodeDes {
    return Intl.message(
      'Enter the code we just sent to email',
      name: 'VerifyCodeDes',
      desc: '',
      args: [],
    );
  }

  /// `Don’t receive the code ?`
  String get Dontreceivethecode {
    return Intl.message(
      'Don’t receive the code ?',
      name: 'Dontreceivethecode',
      desc: '',
      args: [],
    );
  }

  /// `New password `
  String get Newpassword {
    return Intl.message(
      'New password ',
      name: 'Newpassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your new password`
  String get NewpasswordDes {
    return Intl.message(
      'Enter Your new password',
      name: 'NewpasswordDes',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Email can not be empty`
  String get Emailcannotbeempty {
    return Intl.message(
      'Email can not be empty',
      name: 'Emailcannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `password can not be empty`
  String get passwordcannotbeempty {
    return Intl.message(
      'password can not be empty',
      name: 'passwordcannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `name can not be empty`
  String get namecannotbeempty {
    return Intl.message(
      'name can not be empty',
      name: 'namecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get Enteravalidemailaddress {
    return Intl.message(
      'Enter a valid email address',
      name: 'Enteravalidemailaddress',
      desc: '',
      args: [],
    );
  }

  /// `password must be at least 7 characters`
  String get passwordmustbeatleast7characters {
    return Intl.message(
      'password must be at least 7 characters',
      name: 'passwordmustbeatleast7characters',
      desc: '',
      args: [],
    );
  }

  /// `Passwords aren't identical`
  String get Passwordsarentidentical {
    return Intl.message(
      'Passwords aren\'t identical',
      name: 'Passwordsarentidentical',
      desc: '',
      args: [],
    );
  }

  /// `Connection to server failed`
  String get connectionToServerFailed {
    return Intl.message(
      'Connection to server failed',
      name: 'connectionToServerFailed',
      desc: '',
      args: [],
    );
  }

  /// `requestToTheServerWasCancelled`
  String get requestToTheServerWasCancelled {
    return Intl.message(
      'requestToTheServerWasCancelled',
      name: 'requestToTheServerWasCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with the server`
  String get connectionTimeoutWithTheServer {
    return Intl.message(
      'Connection timeout with the server',
      name: 'connectionTimeoutWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Connection to the server failed due to internet connection`
  String get connectionToTheServerFailedDueToInternetConnection {
    return Intl.message(
      'Connection to the server failed due to internet connection',
      name: 'connectionToTheServerFailedDueToInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with the server`
  String get receiveTimeOutInConnectionWithTheServer {
    return Intl.message(
      'Receive timeout in connection with the server',
      name: 'receiveTimeOutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with the server`
  String get sendTimeoutInConnectionWithTheServer {
    return Intl.message(
      'Send timeout in connection with the server',
      name: 'sendTimeoutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred`
  String get UnexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'UnexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Delete your account`
  String get Deleteyouraccount {
    return Intl.message(
      'Delete your account',
      name: 'Deleteyouraccount',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get Logout {
    return Intl.message(
      'Log out',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Cart {
    return Intl.message(
      'Cart',
      name: 'Cart',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get ResendCode {
    return Intl.message(
      'Resend Code',
      name: 'ResendCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get Orders {
    return Intl.message(
      'Orders',
      name: 'Orders',
      desc: '',
      args: [],
    );
  }

  /// `Wish-List`
  String get WishList {
    return Intl.message(
      'Wish-List',
      name: 'WishList',
      desc: '',
      args: [],
    );
  }

  /// `Get Help`
  String get GetHelp {
    return Intl.message(
      'Get Help',
      name: 'GetHelp',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get TermsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'TermsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get AboutApp {
    return Intl.message(
      'About App',
      name: 'AboutApp',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `Account info`
  String get Accountinfo {
    return Intl.message(
      'Account info',
      name: 'Accountinfo',
      desc: '',
      args: [],
    );
  }

  /// `Edit account`
  String get Editaccount {
    return Intl.message(
      'Edit account',
      name: 'Editaccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit account info`
  String get Editaccountinfo {
    return Intl.message(
      'Edit account info',
      name: 'Editaccountinfo',
      desc: '',
      args: [],
    );
  }

  /// `Saved Addresses`
  String get SavedAddresses {
    return Intl.message(
      'Saved Addresses',
      name: 'SavedAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get ChangePassword {
    return Intl.message(
      'Change Password',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Push Notifications`
  String get PushNotifications {
    return Intl.message(
      'Push Notifications',
      name: 'PushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get Deleteaccount {
    return Intl.message(
      'Delete account',
      name: 'Deleteaccount',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get OldPassword {
    return Intl.message(
      'Old Password',
      name: 'OldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Add your old password`
  String get Enteryouroldpassword {
    return Intl.message(
      'Add your old password',
      name: 'Enteryouroldpassword',
      desc: '',
      args: [],
    );
  }

  /// `Add your new password`
  String get Enteryournewpassword {
    return Intl.message(
      'Add your new password',
      name: 'Enteryournewpassword',
      desc: '',
      args: [],
    );
  }

  /// `Sorry failed to featch user data please restart the app or check your internet connection!!`
  String get sorry {
    return Intl.message(
      'Sorry failed to featch user data please restart the app or check your internet connection!!',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectcountry {
    return Intl.message(
      'Select Country',
      name: 'selectcountry',
      desc: '',
      args: [],
    );
  }

  /// `Deleting your account will:`
  String get Deletingyouraccountwill {
    return Intl.message(
      'Deleting your account will:',
      name: 'Deletingyouraccountwill',
      desc: '',
      args: [],
    );
  }

  /// `Delete your account info.`
  String get Deleteyouraccountinfo {
    return Intl.message(
      'Delete your account info.',
      name: 'Deleteyouraccountinfo',
      desc: '',
      args: [],
    );
  }

  /// `Remove all your data.`
  String get Removeallyourdata {
    return Intl.message(
      'Remove all your data.',
      name: 'Removeallyourdata',
      desc: '',
      args: [],
    );
  }

  /// `Delete your history.`
  String get Deleteyourhistory {
    return Intl.message(
      'Delete your history.',
      name: 'Deleteyourhistory',
      desc: '',
      args: [],
    );
  }

  /// `Delete Your Account`
  String get DeleteYourAccount {
    return Intl.message(
      'Delete Your Account',
      name: 'DeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Rewards`
  String get rewards {
    return Intl.message(
      'Rewards',
      name: 'rewards',
      desc: '',
      args: [],
    );
  }

  /// `Procced To Checkout`
  String get ProccedToCheckout {
    return Intl.message(
      'Procced To Checkout',
      name: 'ProccedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `You might like to fit it with`
  String get Youmightliketofititwith {
    return Intl.message(
      'You might like to fit it with',
      name: 'Youmightliketofititwith',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Sub-Categories`
  String get SubCategories {
    return Intl.message(
      'Sub-Categories',
      name: 'SubCategories',
      desc: '',
      args: [],
    );
  }

  /// `Lastest search`
  String get Lastestsearch {
    return Intl.message(
      'Lastest search',
      name: 'Lastestsearch',
      desc: '',
      args: [],
    );
  }

  /// `Popular product`
  String get Popularproduct {
    return Intl.message(
      'Popular product',
      name: 'Popularproduct',
      desc: '',
      args: [],
    );
  }

  /// `City name`
  String get CityName {
    return Intl.message(
      'City name',
      name: 'CityName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your city name`
  String get CityNameDes {
    return Intl.message(
      'Enter Your city name',
      name: 'CityNameDes',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Street name`
  String get StreetName {
    return Intl.message(
      'Enter Your Street name',
      name: 'StreetName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Street name`
  String get StreetNameDes {
    return Intl.message(
      'Enter Your Street name',
      name: 'StreetNameDes',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get BuildingNumber {
    return Intl.message(
      'Building Number',
      name: 'BuildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Building name`
  String get BuildingNumberDes {
    return Intl.message(
      'Enter Your Building name',
      name: 'BuildingNumberDes',
      desc: '',
      args: [],
    );
  }

  /// `Apartment num`
  String get ApartmentNum {
    return Intl.message(
      'Apartment num',
      name: 'ApartmentNum',
      desc: '',
      args: [],
    );
  }

  /// `Apartment num`
  String get ApartmentNumDes {
    return Intl.message(
      'Apartment num',
      name: 'ApartmentNumDes',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number`
  String get FloorNumber {
    return Intl.message(
      'Floor Number',
      name: 'FloorNumber',
      desc: '',
      args: [],
    );
  }

  /// `Floor Number`
  String get FloorNumberDes {
    return Intl.message(
      'Floor Number',
      name: 'FloorNumberDes',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get PhoneNumber {
    return Intl.message(
      'Phone number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Phone number`
  String get PhoneNumberDes {
    return Intl.message(
      'Enter Your Phone number',
      name: 'PhoneNumberDes',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get SaveAddress {
    return Intl.message(
      'Save Address',
      name: 'SaveAddress',
      desc: '',
      args: [],
    );
  }

  /// `What’s Your Location`
  String get WhatsYourLocation {
    return Intl.message(
      'What’s Your Location',
      name: 'WhatsYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `We need to know your location in order to deliver your order`
  String get WhatsYourLocationDes {
    return Intl.message(
      'We need to know your location in order to deliver your order',
      name: 'WhatsYourLocationDes',
      desc: '',
      args: [],
    );
  }

  /// `Allow location Access`
  String get AllowlocationAccess {
    return Intl.message(
      'Allow location Access',
      name: 'AllowlocationAccess',
      desc: '',
      args: [],
    );
  }

  /// `Add location manually`
  String get Addlocationmanually {
    return Intl.message(
      'Add location manually',
      name: 'Addlocationmanually',
      desc: '',
      args: [],
    );
  }

  /// `Add address`
  String get Addaddress {
    return Intl.message(
      'Add address',
      name: 'Addaddress',
      desc: '',
      args: [],
    );
  }

  /// `Already added to cart`
  String get alreadyAddedToCart {
    return Intl.message(
      'Already added to cart',
      name: 'alreadyAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart`
  String get addedToCart {
    return Intl.message(
      'Added to cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get AddToCart {
    return Intl.message(
      'Add to cart',
      name: 'AddToCart',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added to cart`
  String get SuccessfullyAddedToCart {
    return Intl.message(
      'Successfully added to cart',
      name: 'SuccessfullyAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get PlaceOrder {
    return Intl.message(
      'Place Order',
      name: 'PlaceOrder',
      desc: '',
      args: [],
    );
  }

  /// `cash`
  String get cash {
    return Intl.message(
      'cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get Checkout {
    return Intl.message(
      'Checkout',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Pay With`
  String get PayWith {
    return Intl.message(
      'Pay With',
      name: 'PayWith',
      desc: '',
      args: [],
    );
  }

  /// `Discount code`
  String get Discountcode {
    return Intl.message(
      'Discount code',
      name: 'Discountcode',
      desc: '',
      args: [],
    );
  }

  /// `Write Your discount code`
  String get DiscountcodeDes {
    return Intl.message(
      'Write Your discount code',
      name: 'DiscountcodeDes',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message(
      'Apply',
      name: 'Apply',
      desc: '',
      args: [],
    );
  }

  /// `Add New card`
  String get AddNewcard {
    return Intl.message(
      'Add New card',
      name: 'AddNewcard',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid password`
  String get Enteravalidpassword {
    return Intl.message(
      'Enter valid password',
      name: 'Enteravalidpassword',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get SearchResults {
    return Intl.message(
      'Search Results',
      name: 'SearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get PriceRange {
    return Intl.message(
      'Price Range',
      name: 'PriceRange',
      desc: '',
      args: [],
    );
  }

  /// `Min Price`
  String get MinPrice {
    return Intl.message(
      'Min Price',
      name: 'MinPrice',
      desc: '',
      args: [],
    );
  }

  /// `Max Price`
  String get MaxPrice {
    return Intl.message(
      'Max Price',
      name: 'MaxPrice',
      desc: '',
      args: [],
    );
  }

  /// `You need to log in first!`
  String get Youneedtologinfirst {
    return Intl.message(
      'You need to log in first!',
      name: 'Youneedtologinfirst',
      desc: '',
      args: [],
    );
  }

  /// `Must not be empty`
  String get Mustnotbeempty {
    return Intl.message(
      'Must not be empty',
      name: 'Mustnotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Welcome! Nice to meet you`
  String get WelcomeNicetomeetyou {
    return Intl.message(
      'Welcome! Nice to meet you',
      name: 'WelcomeNicetomeetyou',
      desc: '',
      args: [],
    );
  }

  /// `The region's favorite online marketplace`
  String get AhlanNicetomeetyouDes {
    return Intl.message(
      'The region\'s favorite online marketplace',
      name: 'AhlanNicetomeetyouDes',
      desc: '',
      args: [],
    );
  }

  /// `SignIn / SignUp`
  String get SignInSignUp {
    return Intl.message(
      'SignIn / SignUp',
      name: 'SignInSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get Pleaseenteraphonenumber {
    return Intl.message(
      'Please enter a phone number',
      name: 'Pleaseenteraphonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get Tryagain {
    return Intl.message(
      'Try again',
      name: 'Tryagain',
      desc: '',
      args: [],
    );
  }

  /// `I’m a Guest`
  String get ImaGuest {
    return Intl.message(
      'I’m a Guest',
      name: 'ImaGuest',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To `
  String get WelcomeTo {
    return Intl.message(
      'Welcome To ',
      name: 'WelcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Khoyout`
  String get Khoyout {
    return Intl.message(
      'Khoyout',
      name: 'Khoyout',
      desc: '',
      args: [],
    );
  }

  /// `Explore our beautiful collection of hijabs in a variety of styles`
  String get KhoyoutDes {
    return Intl.message(
      'Explore our beautiful collection of hijabs in a variety of styles',
      name: 'KhoyoutDes',
      desc: '',
      args: [],
    );
  }

  /// `Or by social accounts`
  String get Orbysocialaccounts {
    return Intl.message(
      'Or by social accounts',
      name: 'Orbysocialaccounts',
      desc: '',
      args: [],
    );
  }

  /// `Wish-List`
  String get Wishlist {
    return Intl.message(
      'Wish-List',
      name: 'Wishlist',
      desc: '',
      args: [],
    );
  }

  /// `please check terms and conditions`
  String get PleaseCheckTermsAndConditions {
    return Intl.message(
      'please check terms and conditions',
      name: 'PleaseCheckTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Password must be uppercase, lowercase`
  String get PasswordMustbeUpperCaseLowerCase {
    return Intl.message(
      'Password must be uppercase, lowercase',
      name: 'PasswordMustbeUpperCaseLowerCase',
      desc: '',
      args: [],
    );
  }

  /// `a number, and a special character`
  String get AnumberAndAspecialCharacter {
    return Intl.message(
      'a number, and a special character',
      name: 'AnumberAndAspecialCharacter',
      desc: '',
      args: [],
    );
  }

  /// `You need to log in first!`
  String get YouNeedToLoginFirst {
    return Intl.message(
      'You need to log in first!',
      name: 'YouNeedToLoginFirst',
      desc: '',
      args: [],
    );
  }

  /// `failed to load data refresh the page `
  String get failedtoloaddatarefreshthepage {
    return Intl.message(
      'failed to load data refresh the page ',
      name: 'failedtoloaddatarefreshthepage',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get TotalPrice {
    return Intl.message(
      'Total Price',
      name: 'TotalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Choose Your Details`
  String get ChooseYourDetails {
    return Intl.message(
      'Choose Your Details',
      name: 'ChooseYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get Accountdeletedsuccessfully {
    return Intl.message(
      'Account deleted successfully',
      name: 'Accountdeletedsuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
