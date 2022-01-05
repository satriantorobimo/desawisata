import 'package:equatable/equatable.dart';

abstract class ListCategoryEvent extends Equatable {
  const ListCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetListCategory extends ListCategoryEvent {
  final String id;
  final int limit;
  final int page;

  GetListCategory(this.id, this.limit, this.page);
}
