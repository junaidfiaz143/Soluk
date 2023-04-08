import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/bottom_button.dart';
import 'package:app/module/influencer/widgets/dotted_container.dart';
import 'package:app/module/influencer/widgets/image_container.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/influencer/workout/bloc/favorite_ingre_bloc/favorite_cubit.dart';
import 'package:app/module/influencer/workout/bloc/favorite_meal_bloc/favoritemealbloc_cubit.dart';
import 'package:app/module/influencer/workout/widgets/components/ingredientCalcu.dart';
import 'package:app/module/influencer/workout/widgets/components/ingredients.dart';
import 'package:app/module/influencer/workout/widgets/components/meal_classification_dropdown.dart';
import 'package:app/module/influencer/workout/widgets/components/meal_type.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart' as fav;
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/top_appbar_row.dart';

class CreateCustomMealView extends StatefulWidget {
  final Meal? favItem;

  const CreateCustomMealView({Key? key, this.favItem}) : super(key: key);

  @override
  State<CreateCustomMealView> createState() => _CreateCustomMealViewState();
}

class _CreateCustomMealViewState extends State<CreateCustomMealView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? path;
  String? netImage;
  String? mealType;
  String? mealClassi;
  List<int> ingredientsquan = [0, 0, 0, 0];

  pickImage(String source, {CameraMediaType? mediaType}) async {
    path =
        await Pickers.instance.pickImage(source: source, mediaType: mediaType);
    if (path != null) {
      setState(() {});
    }
  }

  removeImage() {
    path = null;
    netImage = null;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    final _favoriteBloc = BlocProvider.of<FavoriteCubit>(context);

    if (widget.favItem != null) {
      _titleController.text = widget.favItem?.title ?? '';
      _descriptionController.text = widget.favItem?.method ?? '';
      mealType = widget.favItem?.mealType;
      mealClassi = widget.favItem?.mealLevel;
      _favoriteBloc.addUpdateIngredients(widget.favItem?.ingredients ?? []);
      netImage = widget.favItem?.imageUrl;
    } else {
      _favoriteBloc.addUpdateIngredients([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _favoriteBloc = BlocProvider.of<FavoriteCubit>(context);
    return Scaffold(
      body: Column(
        children: [
          TopAppbarRow(
            title: 'Customize Meal',
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    netImage == null && path == null
                        ? MediaTypeSelectionCard(
                            callback: () => popUpAlertDialog(
                              context,
                              'Pick Image',
                              LKImageDialogDetail,
                              isProfile: true,
                              onCameraTap: (type) {
                                pickImage(Pickers.instance.sourceCamera,
                                    mediaType: type);
                              },
                              onGalleryTap: () {
                                pickImage(Pickers.instance.sourceGallery);
                              },
                            ),
                          )
                        : ImageContainer(
                            path: path ?? netImage!,
                            onClose: () => removeImage(),
                          ),
                    // const DottedContainer(),
                    SB_1H,

                    SalukTextField(
                      textEditingController: _titleController,
                      hintText: '',
                      labelText:
                          AppLocalisation.getTranslated(context, 'LKMealTitle'),
                      onChange: (_) {
                        // setState(() {});
                      },
                    ),
                    SB_1H,
                    MealTypeDropDown(
                        onValueChanged: (value) => mealType = value,
                        mealType: mealType),
                    SB_1H,
                    MealClassificationDropDown(
                        onValueChanged: (value) => mealClassi = value,
                        mealClassi: mealClassi),
                    SB_1H,
                    IngredientCalcu(calcuIngre: (li) => ingredientsquan = li),
                    SB_1H,
                    const Ingredients(),
                    SB_1H,
                    SalukTextField(
                      maxLines: 5,
                      textEditingController: _descriptionController,
                      hintText: "",
                      labelText: AppLocalisation.getTranslated(
                          context, 'LKMethodInstruction'),
                    ),
                    SB_2H,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: SalukBottomButton(
              title: AppLocalisation.getTranslated(context, 'LKSubmit'),
              callback: () async {
                if (widget.favItem == null) {
                  print('nullllllllllllll11144');
                  addMeal();
                } else {
                  print('not nullllllllllllllll');
                  update();
                }
              },
              isButtonDisabled: false // _titleController.text.isEmpty,
              )),
    );
  }

  update() async {
    Map<String, String> body = {
      'fav_meal_id': '${widget.favItem!.id!}',
      'title': _titleController.text,
      'mealtype': mealType ?? "",
      'mealLevel': mealClassi ?? '',
      'calories': '${ingredientsquan[0]}',
      'proteins': '${ingredientsquan[1]}',
      'fats': '${ingredientsquan[2]}',
      'carbs': '${ingredientsquan[3]}',
      'method': _descriptionController.text,
    };

    List<fav.Ingredients> ingre =
        BlocProvider.of<FavoriteCubit>(context, listen: false)
            .state
            .ingredients;
    for (var i = 0; i < ingre.length; i++) {
      body['ingredient[$i][ingredient_id]'] = "${ingre[i].id}";
      body['ingredient[$i][name]'] = "${ingre[i].name}";
      body['ingredient[$i][type]'] = "${ingre[i].type}";
      body['ingredient[$i][quantity]'] = "${ingre[i].quantity}";
      body['ingredient[$i][proteins]'] = "${ingre[i].proteins}";
      body['ingredient[$i][carbs]'] = "${ingre[i].carbs}";
      body['ingredient[$i][fats]'] = "${ingre[i].fats}";
      body['ingredient[$i][calories]'] = "${ingre[i].calories}";
    }
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res =
        await BlocProvider.of<FavoritemealblocCubit>(context, listen: false)
            .updateFavoriteMeal(body, fields, paths);
    if (res) {
      BlocProvider.of<FavoriteCubit>(context, listen: false).clearIngredients();
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  addMeal() async {
    Map<String, String> body = {
      'title': _titleController.text,
      'mealtype': mealType ?? "",
      'mealLevel': mealClassi ?? '',
      'calories': '${ingredientsquan[0]}',
      'proteins': '${ingredientsquan[1]}',
      'fats': '${ingredientsquan[2]}',
      'carbs': '${ingredientsquan[3]}',
      'method': _descriptionController.text,
    };

    List<fav.Ingredients> ingre =
        BlocProvider.of<FavoriteCubit>(context, listen: false)
            .state
            .ingredients;
    for (var i = 0; i < ingre.length; i++) {
      body['ingredient[$i][name]'] = "${ingre[i].name}";
      body['ingredient[$i][type]'] = "${ingre[i].type}";
      body['ingredient[$i][quantity]'] = "${ingre[i].quantity}";
      body['ingredient[$i][proteins]'] = "${ingre[i].proteins}";
      body['ingredient[$i][carbs]'] = "${ingre[i].carbs}";
      body['ingredient[$i][fats]'] = "${ingre[i].fats}";
      body['ingredient[$i][calories]'] = "${ingre[i].calories}";
    }
    List<String> fields = [];
    List<String> paths = [];
    if (path != null) {
      fields.add('imageURL');
      paths.add(path!);
    }
    print(body);
    bool res =
        await BlocProvider.of<FavoritemealblocCubit>(context, listen: false)
            .addFavoriteMeal(body, fields, paths);
    if (res) {
      BlocProvider.of<FavoriteCubit>(context, listen: false).clearIngredients();
      Navigator.pop(context);
    }
  }
}
