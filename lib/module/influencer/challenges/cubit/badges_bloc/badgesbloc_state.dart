part of 'badgesbloc_cubit.dart';

@immutable
abstract class BadgesblocState {
  final BadgesModal? badges;
  const BadgesblocState({this.badges});
}

class BadgesblocInitial extends BadgesblocState {}
class BadgesblocLoading extends BadgesblocState {
  const BadgesblocLoading() : super();
}


class BadgesblocLoaded extends BadgesblocState {
  const BadgesblocLoaded({BadgesModal? badges})
      : super(badges: badges);
}
