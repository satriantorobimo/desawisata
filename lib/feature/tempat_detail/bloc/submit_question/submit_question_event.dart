import 'package:equatable/equatable.dart';

abstract class SubmitQuestionEvent extends Equatable {
  const SubmitQuestionEvent();

  @override
  List<Object> get props => [];
}

class GetSubmitQuestion extends SubmitQuestionEvent {
  final String id;
  final String value;

  GetSubmitQuestion(this.id, this.value);
}
