import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/empty_screen.dart';
import 'package:app/module/user/profile/local_storage/grocery_local.dart';
import 'package:app/module/user/profile/widgets/grocery_card.dart';
import 'package:app/module/user/profile/widgets/pop_up_ingredient_dialog.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GroceryScreen extends StatelessWidget {
  static const String id = "/grocery_settings";
  GroceryScreen({Key? key}) : super(key: key);
  final GroceryLocal ins = GroceryLocal.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: AppBody(
        bgColor: backgroundColor,
        title: "Grocery List",
        body: ValueListenableBuilder<Box>(
            valueListenable: ins.groceryBox.listenable(),
            builder: (context, box, widget) {
              List list = box.get(LSKeyGroceryList, defaultValue: []);
              if (list.isEmpty) {
                return EmptyScreen(
                  title: "Add Grocery",
                  callback: () => popUpIngredientDialog(context, 'Ingredients',
                      onSave: ((name, quantity, stand) {
                    ins.addItem(
                        {'name': name, 'quantity': quantity, 'type': stand});
                  })),
                );
              }
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  Map item = list[i];
                  return GroceryCard(
                    index: i,
                    item: item,
                  );
                },
              );
            }),
      ),
      floatingActionButton: ValueListenableBuilder<Box>(
        valueListenable:ins.groceryBox.listenable(),
        builder: (context, box, widget) {
          List list = box.get(LSKeyGroceryList, defaultValue: []);
          return /*list.isNotEmpty
              ?*/ FloatingActionButton(
                  onPressed: () => popUpIngredientDialog(context, 'Ingredients',
                      onSave: ((name,
                          quantity, stand) {
                    ins.addItem(
                        {'name': name, 'quantity': quantity, 'type': stand});
                  })),
                  child: Icon(
                    Icons.add,
                    size: WIDTH_4,
                  ),
                  backgroundColor: PRIMARY_COLOR,
                );
              /*: Container();*/
        },
      ),
    );
  }
}
