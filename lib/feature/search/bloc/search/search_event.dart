import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchValue extends SearchEvent {
  final String value;

  GetSearchValue(this.value);
}
