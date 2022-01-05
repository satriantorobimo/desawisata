import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/search/domain/repo/search_repo.dart';
import 'package:desa_wisata_nusantara/feature/search/model/search_model.dart';
import 'package:flutter/material.dart';
import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({@required this.searchRepo})
      : assert(searchRepo != null),
        super(SearchInitial());

  SearchModel searchModel;
  final SearchRepo searchRepo;

  SearchState get initialState => SearchInitial();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchValue) {
      yield SearchLoading();
      try {
        searchModel = await searchRepo.getSearchValue(event.value);
        if (searchModel.items.isNotEmpty) {
          yield SearchLoaded(searchModel: searchModel);
        } else {
          yield SearchError('no_data');
        }
      } catch (e) {
        yield SearchException('error');
      }
    }
  }
}
