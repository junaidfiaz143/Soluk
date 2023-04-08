import 'package:app/module/user/widgets/text_view.dart';
import 'package:app/res/color.dart';
import 'package:app/utils/nav_router.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../res/constants.dart';
import '../../../../../../res/globals.dart';
import '../../../../models/meals/dashboard_meals_model.dart';
import '../../../bloc/dashboard_meals_bloc.dart';
import 'create_custom_meal_view.dart';
import 'custom_meal_list_view.dart';

class CustomMealsTab extends StatefulWidget {
  const CustomMealsTab({Key? key, required this.mealIds}) : super(key: key);
  final List<int> mealIds;

  @override
  State<CustomMealsTab> createState() => _CustomMealsTabState();
}

class _CustomMealsTabState extends State<CustomMealsTab> {
  bool hasData = true;

  late DashboardMealsBloc _dashboardMealsBloc;

  @override
  void initState() {
    super.initState();
    _dashboardMealsBloc = BlocProvider.of(context);
    _dashboardMealsBloc.getCustomMealsList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              TextView('Custom Meals',
                  fontWeight: FontWeight.w600, fontSize: 15),
              SizedBox(height: 10),
              TextView(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                fontSize: 15,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        StreamBuilder<DashboardMealsModel?>(
          stream: _dashboardMealsBloc.customMealStream,
          initialData: null,
          builder: (context, snapshot) {
            return Expanded(
              child: (snapshot.data?.responseDetails?.data != null && snapshot.data!.responseDetails!.data!.length>0)
                  ? Column(
                children: [
                          CreateMealDottedContainerWidget(),
                          Divider(
                            thickness: 1,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Expanded(
                              child: CustomMealsListView(
                            mealIds: widget.mealIds,
                            meals: snapshot.data!.responseDetails!.data!,
                          )),
                        ],
                      )
                  : Center(
                      child: CreateMealWidget(),
                    ),
            );
          }
        )
      ],
    );
  }
}

class CreateMealDottedContainerWidget extends StatelessWidget {
  const CreateMealDottedContainerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavRouter.push(context, CreateCustomMealView());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10) +
            EdgeInsets.only(top: 10, bottom: 4),
        child: DottedBorder(
          padding: EdgeInsets.all(14),
          radius: Radius.circular(10),
          borderType: BorderType.RRect,
          dashPattern: const [5, 5],
          child: Center(
              child: TextView(
            '+  Create Meal',
            color: PRIMARY_COLOR,
            fontSize: 15,
          )),
          color: PRIMARY_COLOR,
        ),
      ),
    );
  }
}

class CreateMealWidget extends StatelessWidget {
  const CreateMealWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              NavRouter.push(context, CreateCustomMealView());
            },
            child: SvgPicture.asset(PLUS_ICON)),
        const SizedBox(height: 14),
        Text(
          'Create Meal',
          style: subTitleTextStyle(context)
              ?.copyWith(fontSize: defaultSize.screenWidth * .040),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Diam sollicitudin porttitor turpis non at nec facilisis lacus.",
            textAlign: TextAlign.center,
            style: hintTextStyle(context),
          ),
        ),
      ],
    );
  }
}
