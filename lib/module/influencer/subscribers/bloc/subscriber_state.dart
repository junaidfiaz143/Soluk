part of 'subscriber_bloc.dart';

abstract class SubscriberState extends Equatable {
  const SubscriberState();

  @override
  List<Object> get props => [];
}

class SubscribersListLoadingState extends SubscriberState{}

class SubscribersListLoadedState extends SubscriberState{
  final List<Data>? _subscribersList;

  const SubscribersListLoadedState(this._subscribersList);

  List<Data>? get subscribersList => _subscribersList;
}

class ErrorState extends SubscriberState{}