part of 'nutrientsbloc_cubit.dart';

@immutable
abstract class NutrientsblocState {
  final NutrientsModal? nutrientsData;
  const NutrientsblocState({this.nutrientsData});
}

class NutrientsblocInitial extends NutrientsblocState {}
class NutrientsLoading extends NutrientsblocState {
  const NutrientsLoading() : super();
}
class NutrientsblocEmpty extends NutrientsblocState {
  const NutrientsblocEmpty() : super();
}
class NutrientsblocLoaded extends NutrientsblocState {
  const NutrientsblocLoaded({NutrientsModal? nutrientsData}) : super(nutrientsData: nutrientsData);
}
