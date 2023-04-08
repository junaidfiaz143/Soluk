import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
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
import 'package:app/module/user/meals/bloc/meal_cubit.dart';
import 'package:app/module/user/models/meal/meal_dashboard.dart' as fav;
import 'package:app/module/user/models/meals/dashboard_meals_model.dart';
import 'package:app/repo/repository/web_service.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/color.dart';
import '../../more/widget/custom_alert_dialog.dart';
import '../../widgets/media_upload_progress_popup.dart';
import '../../widgets/show_snackbar.dart';

class AddFavoriteMeal extends StatefulWidget {
  final Meal? favItem;

  const AddFavoriteMeal({Key? key, this.favItem}) : super(key: key);

  @override
  State<AddFavoriteMeal> createState() => _AddFavoriteMealState();
}

class _AddFavoriteMealState extends State<AddFavoriteMeal> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? path;
  String? netImage;
  String? mealType;
  String? mealClassi;
  List<int> ingredientsquan = [0, 0, 0, 0];
  List<int> initialIngredientValues = [0, 0, 0, 0, 0];
  List<IngredientInitialValue> initValues = [];
  int numberOfRounds = 1;

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
      // if ((widget.favItem?.ingredients?.length ?? 0) > 0) {
      //   widget.favItem?.ingredients?.forEach((element) {
      //     initValues.add(new IngredientInitialValue(
      //         element.fats,
      //         element.calories,
      //         element.carbs,
      //         element.proteins,
      //         element.quantity));
      //   });
      // }
      netImage = widget.favItem?.imageUrl;
    } else {
      _favoriteBloc.addUpdateIngredients([]);
    }
  }

  revertIngredientChanges() {
    // if ((widget.favItem?.ingredients?.length ?? 0) > 0) {
    //   for (int a = 0; a < (widget.favItem?.ingredients?.length ?? 0); a++) {
    //     widget.favItem?.ingredients?[a].fats = initValues[a].initFats;
    //     widget.favItem?.ingredients?[a].proteins = initValues[a].initPro;
    //     widget.favItem?.ingredients?[a].calories = initValues[a].initCal;
    //     widget.favItem?.ingredients?[a].carbs = initValues[a].initCarbs;
    //     widget.favItem?.ingredients?[a].quantity = initValues[a].initQua;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _favoriteBloc = BlocProvider.of<FavoriteCubit>(context);
    return WillPopScope(
      onWillPop: () async {
        revertIngredientChanges();
        return true;
      },
      child: Scaffold(
        body: AppBody(
          title: 'Favorite Meal',
          showBackButton: true,
          callback: () {
            revertIngredientChanges();
          },
          // applyPaddingH: false,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                netImage == null && path == null
                    ? MediaTypeSelectionCard(
                        textTag: LKUploadImagePreview,
                        callback: () => popUpAlertDialog(
                          context,
                          'Pick Image',
                          LKImageDialogDetail,
                          mediaType: CameraMediaType.IMAGE,
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z ]")),
                  ],
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
                Ingredients(),
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
        bottomNavigationBar: BottomAppBar(
            child: StreamBuilder<ProgressFile>(
                stream: BlocProvider.of<FavoritemealblocCubit>(context)
                    .progressStream,
                builder: (context, snapshot) {
                  return SalukBottomButton(
                      title: AppLocalisation.getTranslated(context, 'LKSubmit'),
                      callback: () async {
                        if (!validateInput()) {
                          return;
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return StreamBuilder<ProgressFile>(
                                stream: BlocProvider.of<FavoritemealblocCubit>(
                                        context)
                                    .progressStream,
                                builder: (context, snapshot) {
                                  return CustomAlertDialog(
                                    isSmallSize: true,
                                    contentWidget: MediaUploadProgressPopup(
                                      snapshot: snapshot,
                                    ),
                                  );
                                });
                          },
                        );

                        if (widget.favItem == null) {
                          addMeal();
                        } else {
                          print('not nullllllllllllllll');
                          update();
                        }
                      },
                      isButtonDisabled: false // _titleController.text.isEmpty,
                      );
                })),
      ),
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

    List<fav.Ingredients> ing = [];
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

    await BlocProvider.of<MealCubit>(context).updateExistingMealInfo(Meal(
        id: widget.favItem!.id!,
        resturantId: widget.favItem?.resturantId,
        imageUrl: path,
        title: _titleController.text,
        mealType: mealType ?? "",
        mealLevel: mealClassi ?? '',
        calories: ingredientsquan[0],
        proteins: ingredientsquan[1],
        fats: ingredientsquan[2],
        carbs: ingredientsquan[3],
        method: _descriptionController.text,
        ingredients: ingre));
    await BlocProvider.of<MealCubit>(context)
        .getMealInfo(BlocProvider.of<MealCubit>(context).currentDay);

    bool res =
        await BlocProvider.of<FavoritemealblocCubit>(context, listen: false)
            .updateFavoriteMeal(body, fields, paths);
    if (res) {
      BlocProvider.of<FavoriteCubit>(context, listen: false).clearIngredients();
      Navigator.pop(context);
      Navigator.pop(context);
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
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  bool validateInput() {
    List<fav.Ingredients> ingre =
        BlocProvider.of<FavoriteCubit>(context, listen: false)
            .state
            .ingredients;

    if ((path == null || path!.isEmpty) &&
        (netImage == null || netImage!.isEmpty)) {
      showSnackBar(
        context,
        "Please add Preview Image",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (_titleController.text.isEmpty) {
      showSnackBar(
        context,
        "Please add Title",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (mealClassi == null || mealClassi!.isEmpty) {
      showSnackBar(
        context,
        "Please select Meal Classification",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (mealType == null || mealType!.isEmpty) {
      showSnackBar(
        context,
        "Please select Meal Type",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    if (ingre.isEmpty) {
      showSnackBar(
        context,
        "Please add Ingredients",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    }

    if (_descriptionController.text.isEmpty) {
      showSnackBar(
        context,
        "Please write Description",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    return true;
  }
}

class IngredientInitialValue {
  int? initFats = 0;
  int? initCal = 0;
  int? initCarbs = 0;
  int? initPro = 0;
  int? initQua = 0;

  IngredientInitialValue(
      this.initFats, this.initCal, this.initCarbs, this.initPro, this.initQua);
}
