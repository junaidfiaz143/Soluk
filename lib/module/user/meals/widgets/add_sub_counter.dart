import 'package:flutter/material.dart';

import '../../../../res/color.dart';
import '../../../../res/globals.dart';
import '../../models/meals/dashboard_meals_model.dart';

class AddSubCounter extends StatefulWidget {
  const AddSubCounter({Key? key, required this.meal}) : super(key: key);
  final Meal? meal;

  @override
  _AddSubCounterState createState() => _AddSubCounterState();
}

class _AddSubCounterState extends State<AddSubCounter> {
  int numberOfRounds = 1;
  int calorie = 0;
  int fat = 0;
  int proteins = 0;
  int carbs = 0;
  List<IngredientInitialValues> _list = [];

  @override
  void initState() {
    calorie = widget.meal?.calories ?? 0;
    fat = widget.meal?.fats ?? 0;
    proteins = widget.meal?.proteins ?? 0;
    carbs = widget.meal?.carbs ?? 0;
    for (int i = 0; i < (widget.meal?.ingredients?.length ?? 0); i++) {
      _list.add(IngredientInitialValues(
          widget.meal?.ingredients?[i].quantity ?? 0,
          widget.meal?.ingredients?[i].calories ?? 0,
          widget.meal?.ingredients?[i].fats ?? 0,
          widget.meal?.ingredients?[i].proteins ?? 0,
          widget.meal?.ingredients?[i].carbs ?? 0));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 100,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            color: SCAFFOLD_BACKGROUND_COLOR,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: PRIMARY_COLOR,
                ),
                child: InkWell(
                  onTap: () {
                    if (numberOfRounds > 1) {
                      numberOfRounds = numberOfRounds - 1;
                      for (int i = 0;
                          i < (widget.meal?.ingredients?.length ?? 0);
                          i++) {
                        widget.meal?.ingredients?[i].proteins =
                            (widget.meal?.ingredients?[i].proteins ?? 0) -
                                _list[i].proteins;
                        widget.meal?.ingredients?[i].calories =
                            (widget.meal?.ingredients?[i].calories ?? 0) -
                                _list[i].calorie;
                        widget.meal?.ingredients?[i].fats =
                            (widget.meal?.ingredients?[i].fats ?? 0) -
                                _list[i].fat;
                        widget.meal?.ingredients?[i].carbs =
                            (widget.meal?.ingredients?[i].carbs ?? 0) -
                                _list[i].carbs;
                        widget.meal?.ingredients?[i].quantity =
                            (widget.meal?.ingredients?[i].quantity ?? 0) -
                                _list[i].quantity;
                      }

                      widget.meal?.calories =
                          (widget.meal?.calories ?? 0) - calorie;
                      widget.meal?.proteins =
                          (widget.meal?.proteins ?? 0) - proteins;
                      widget.meal?.fats = (widget.meal?.fats ?? 0) - fat;
                      widget.meal?.carbs = (widget.meal?.carbs ?? 0) - carbs;
                      setState(() {});
                    } else if (numberOfRounds == 1) {
                      numberOfRounds = -1;
                      for (int i = 0;
                          i < (widget.meal?.ingredients?.length ?? 0);
                          i++) {
                        widget.meal?.ingredients?[i].proteins =
                            ((widget.meal?.ingredients?[i].proteins ?? 0) * 0.5)
                                .toInt();
                        widget.meal?.ingredients?[i].calories =
                            ((widget.meal?.ingredients?[i].calories ?? 0) * 0.5)
                                .toInt();
                        widget.meal?.ingredients?[i].fats =
                            ((widget.meal?.ingredients?[i].fats ?? 0) * 0.5)
                                .toInt();
                        widget.meal?.ingredients?[i].carbs =
                            ((widget.meal?.ingredients?[i].carbs ?? 0) * 0.5)
                                .toInt();
                        widget.meal?.ingredients?[i].quantity =
                            ((widget.meal?.ingredients?[i].quantity ?? 0) * 0.5)
                                .toInt();
                      }

                      widget.meal?.calories =
                          ((widget.meal?.calories ?? 0) * 0.5).toInt();
                      widget.meal?.proteins =
                          ((widget.meal?.proteins ?? 0) * 0.5).toInt();
                      widget.meal?.fats =
                          ((widget.meal?.fats ?? 0) * 0.5).toInt();
                      widget.meal?.carbs =
                          ((widget.meal?.carbs ?? 0) * 0.5).toInt();
                      setState(() {});
                    }
                  },
                  child: Center(
                    child: Text(
                      '-',
                      style: labelTextStyle(context)
                          ?.copyWith(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
              Text(
                '${numberOfRounds == -1 ? '0.5' : numberOfRounds}',
                style: labelTextStyle(context)?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: PRIMARY_COLOR,
                ),
                child: InkWell(
                  onTap: () {
                    if (numberOfRounds == -1) {
                      numberOfRounds = 1;
                      for (int i = 0;
                          i < (widget.meal?.ingredients?.length ?? 0);
                          i++) {
                        widget.meal?.ingredients?[i].proteins =
                            _list[i].proteins;
                        widget.meal?.ingredients?[i].calories =
                            _list[i].calorie;
                        widget.meal?.ingredients?[i].fats = _list[i].fat;
                        widget.meal?.ingredients?[i].carbs = _list[i].carbs;
                        widget.meal?.ingredients?[i].quantity =
                            _list[i].quantity;
                      }
                      widget.meal?.calories = calorie;
                      widget.meal?.proteins = proteins;
                      widget.meal?.fats = fat;
                      widget.meal?.carbs = carbs;
                    } else {
                      numberOfRounds = numberOfRounds + 1;
                      for (int i = 0;
                          i < (widget.meal?.ingredients?.length ?? 0);
                          i++) {
                        widget.meal?.ingredients?[i].proteins =
                            _list[i].proteins * numberOfRounds;
                        widget.meal?.ingredients?[i].calories =
                            _list[i].calorie * numberOfRounds;
                        widget.meal?.ingredients?[i].fats =
                            _list[i].fat * numberOfRounds;
                        widget.meal?.ingredients?[i].carbs =
                            _list[i].carbs * numberOfRounds;
                        widget.meal?.ingredients?[i].quantity =
                            _list[i].quantity * numberOfRounds;
                      }
                      widget.meal?.calories = calorie * numberOfRounds;
                      widget.meal?.proteins = proteins * numberOfRounds;
                      widget.meal?.fats = fat * numberOfRounds;
                      widget.meal?.carbs = carbs * numberOfRounds;
                    }

                    setState(() {});
                  },
                  child: Center(
                    child: Text(
                      '+',
                      style: labelTextStyle(context)
                          ?.copyWith(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class IngredientInitialValues {
  int quantity = 0;
  int calorie = 0;
  int fat = 0;
  int proteins = 0;
  int carbs = 0;

  IngredientInitialValues(
      this.quantity, this.calorie, this.fat, this.proteins, this.carbs);
}
