part of 'sociallinksbloc_cubit.dart';

@immutable
abstract class SociallinksblocState {
  final SocialLinksModal? socialLinks;
  const SociallinksblocState({this.socialLinks});
}

class SociallinksblocInitial extends SociallinksblocState {}
class SocialLinksLoading extends SociallinksblocState {
  const SocialLinksLoading():super();
}
class SocialLinksEmpty extends SociallinksblocState {
  const SocialLinksEmpty():super();
}
class SociallinksLoaded extends SociallinksblocState {
  const SociallinksLoaded({SocialLinksModal? socialLinks}):super(socialLinks: socialLinks);
}
