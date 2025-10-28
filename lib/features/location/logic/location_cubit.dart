import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);
  int currentPageIndex = 0;

  List<String> locations = [
    'Apartment',
    'Office',
    'House',
  ];
  
  void changeCurrentIndex(int index) {
    currentPageIndex = index;
    emit(ChangeButtonIndex());
  }
}
