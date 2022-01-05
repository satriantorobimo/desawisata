import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/home/domain/repo/category_home_repo.dart';
import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class CategoryHomeBloc extends Bloc<CategoryHomeEvent, CategoryHomeState> {
  CategoryHomeBloc({@required this.categoryHomeRepo})
      : assert(categoryHomeRepo != null),
        super(CategoryHomeInitial());

  CategoryHomeModel categoryHomeModel;
  final CategoryHomeRepo categoryHomeRepo;

  CategoryHomeState get initialState => CategoryHomeInitial();

  @override
  Stream<CategoryHomeState> mapEventToState(
    CategoryHomeEvent event,
  ) async* {
    if (event is GetCategoryHome) {
      yield CategoryHomeLoading();
      try {
        categoryHomeModel = await categoryHomeRepo.getCategoryHome();
        if (categoryHomeModel.status) {
          yield CategoryHomeLoaded(categoryHomeModel: categoryHomeModel);
        } else {
          yield CategoryHomeError('no_data');
        }
      } catch (e) {
        yield CategoryHomeException('error');
      }
    }
  }
}
