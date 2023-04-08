import 'package:app/module/influencer/challenges/model/participant_modal.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class ParticipantBlocState {
  final ParticipantModal? participantModal;
  final List<DataParticipant>? filterList;

  const ParticipantBlocState({this.participantModal, this.filterList});
}

class ParticipantBlocInitial extends ParticipantBlocState {}

class ParticipantsLoading extends ParticipantBlocState {
  const ParticipantsLoading() : super();
}

class ParticipantsEmpty extends ParticipantBlocState {
  const ParticipantsEmpty() : super();
}

class ParticipantsLoaded extends ParticipantBlocState {
  const ParticipantsLoaded(
      {ParticipantModal? participantModal, List<DataParticipant>? filterList})
      : super(participantModal: participantModal, filterList: filterList);
}
