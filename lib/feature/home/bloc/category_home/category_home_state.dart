import 'package:desa_wisata_nusantara/feature/home/model/category_home_model.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryHomeState extends Equatable {
  const CategoryHomeState();

  @override
  List<Object> get props => [];
}

class CategoryHomeInitial extends CategoryHomeState {}

class CategoryHomeLoading extends CategoryHomeState {}

class CategoryHomeLoaded extends CategoryHomeState {
  const CategoryHomeLoaded({this.categoryHomeModel});
  final CategoryHomeModel categoryHomeModel;

  @override
  List<Object> get props => [categoryHomeModel];
}

class CategoryHomeError extends CategoryHomeState {
  const CategoryHomeError(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}

class CategoryHomeException extends CategoryHomeState {
  const CategoryHomeException(this.error) : assert(error != null);
  final String error;

  @override
  List<Object> get props => [error];
}
