import 'package:bloc/bloc.dart';
import 'package:desa_wisata_nusantara/feature/tempat_detail/domain/repo/tempat_detail_repo.dart';

import 'package:desa_wisata_nusantara/feature/tempat_detail/model/submit_question_model.dart';

import 'package:flutter/material.dart';
import 'bloc.dart';

class SubmitQuestionBloc
    extends Bloc<SubmitQuestionEvent, SubmitQuestionState> {
  SubmitQuestionBloc({@required this.tempatDetailRepo})
      : assert(tempatDetailRepo != null),
        super(SubmitQuestionInitial());

  SubmitQuestionModel submitQuestionModel;
  final TempatDetailRepo tempatDetailRepo;

  SubmitQuestionState get initialState => SubmitQuestionInitial();

  @override
  Stream<SubmitQuestionState> mapEventToState(
    SubmitQuestionEvent event,
  ) async* {
    if (event is GetSubmitQuestion) {
      yield SubmitQuestionLoading();
      try {
        submitQuestionModel =
            await tempatDetailRepo.submitQuestion(event.id, event.value);
        if (submitQuestionModel.status) {
          yield SubmitQuestionLoaded(submitQuestionModel: submitQuestionModel);
        } else {
          yield SubmitQuestionError('no_data');
        }
      } catch (e) {
        yield SubmitQuestionError('error');
      }
    }
  }
}
