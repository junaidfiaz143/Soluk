part of 'promobloc_cubit.dart';

@immutable
abstract class PromoblocState {
  final PromoCodeModal? promoCode;
  const PromoblocState({this.promoCode});
}

class PromoblocInitial extends PromoblocState {}
class PromoEmpty extends PromoblocState {
  const PromoEmpty():super();
}
class PromoLoading extends PromoblocState {
  const PromoLoading():super();
}
class PromoDialogLoading extends PromoblocState {
  const PromoDialogLoading():super();
}
class PromoLoaded extends PromoblocState {
  const PromoLoaded({PromoCodeModal? promoCode}):super(promoCode: promoCode);
}
