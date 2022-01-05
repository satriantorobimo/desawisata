import 'package:equatable/equatable.dart';

abstract class CategoryHomeEvent extends Equatable {
  const CategoryHomeEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryHome extends CategoryHomeEvent {}
