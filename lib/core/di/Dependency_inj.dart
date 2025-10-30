
import 'package:get_it/get_it.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/features/auth/data/repos/auth_repo.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/cart/data/repos/cart_repo.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/category/data/repos/category_repo.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/favorite/data/repos/fav_repo.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/data/repos/home_repo.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/features/product_details/data/repo/Product_dtails_repo.dart';
import 'package:khouyot/features/product_details/logic/product_details_cubit.dart';
import 'package:khouyot/features/profile/data/repos/profile_repo.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/search/data/repos/search_repo.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/splash/ui/screens/data/repo/splash_repo.dart';
import 'package:khouyot/features/splash/ui/screens/logic/cubit/splash_cubit.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();
  
  // Register AuthRepo and AuthCubit
  getIt.registerFactory<AuthRepo>(() => AuthRepo(dio));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Register HomeCubit with HomeRepo
  getIt.registerFactory<HomeRepo>(() => HomeRepo(dio));
  getIt.registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()));

  // Register CategoryCubit with Category
  getIt.registerFactory<CategoryRepo>(() => CategoryRepo(dio));
  getIt.registerLazySingleton<CategoryCubit>(() => CategoryCubit(getIt()));
// Register ProductDetailsCubit with ProductDetails
  getIt.registerFactory<ProductDetailsRepo>(() => ProductDetailsRepo(dio));
  getIt.registerLazySingleton<ProductDetailsCubit>(() => ProductDetailsCubit(getIt()));

  // Register ProfileCubit with ProfileRepo
  getIt.registerFactory<ProfileRepo>(() => ProfileRepo(dio));
  getIt.registerLazySingleton<ProfileCubit>(() => ProfileCubit(getIt()));

  //Register CartCubit with CartRepo
  getIt.registerFactory<CartRepo>(() => CartRepo(dio));
  getIt.registerLazySingleton<CartCubit>(() => CartCubit(getIt()));

  //Register CartCubit with CartRepo
  getIt.registerLazySingleton<NavBarCubit>(() => NavBarCubit());

  //Register CartCubit with CartRepo
  getIt.registerFactory<SearchRepo>(() => SearchRepo(dio));
  getIt.registerLazySingleton<SearchCubit>(() => SearchCubit(getIt()));

  //Register CartCubit with CartRepo
  getIt.registerFactory<FavRepo>(() => FavRepo(dio));
  getIt.registerLazySingleton<FavCubit>(() => FavCubit(getIt()));

  getIt.registerFactory<SplashRepo>(() => SplashRepo(dio));
  getIt.registerLazySingleton<SplashCubit>(() => SplashCubit(getIt()));

}
