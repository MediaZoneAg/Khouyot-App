
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/features/search/data/repos/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchRepo searchRepo;
  List<ProductModel> searchResults = [];
  String currentCategoryId = "";
  double minPrice = 0;
  double maxPrice = 100000;
  String categoryName = "";

  final List<String> searches = [
    'white pull over',
    'T-shirt',
  ];

  void changeCategoryId( String id) {
    currentCategoryId = id;
    emit(ChangeBody());
  }

  Future<void> fetchSearchResults(String search) async {
    emit(SearchLoading());
    var result = await searchRepo.getSearch(
        search: search,
        minPrice: minPrice,
        maxPrice: maxPrice,
        currentCategoryId: currentCategoryId);
    result.fold(
      (failure) {
        emit(SearchFailure(failure));
      },
      (response) {
        searchResults = response;
        emit(SearchSuccess());
      },
    );
  }
}
