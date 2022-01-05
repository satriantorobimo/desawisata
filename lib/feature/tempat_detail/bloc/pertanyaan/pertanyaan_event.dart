import 'package:equatable/equatable.dart';

abstract class PertanyaanEvent extends Equatable {
  const PertanyaanEvent();

  @override
  List<Object> get props => [];
}

class GetPertanyaan extends PertanyaanEvent {
  final String id;
  final int limit;
  final int page;

  GetPertanyaan(this.id, this.limit, this.page);
}
