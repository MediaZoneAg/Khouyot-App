
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/splash/ui/screens/data/repo/splash_repo.dart';
import 'package:meta/meta.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.splashRepo) : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);
  SplashRepo splashRepo;
  Future<bool> checkToken(String token) async {
    bool isValue = false;
    final response = await splashRepo.checkToken(token);
    await response.fold((l) async {
      isValue = false;
    }, (r) async {
      isValue = true;
    });
    return isValue;
  }
}