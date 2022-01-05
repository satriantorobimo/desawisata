import 'package:equatable/equatable.dart';

abstract class ListDesaEvent extends Equatable {
  const ListDesaEvent();

  @override
  List<Object> get props => [];
}

class GetListDesa extends ListDesaEvent {
  final String id;
  final int limit;
  final int page;

  GetListDesa(this.id, this.limit, this.page);
}
