import 'package:app/res/constants.dart';
import 'package:hive/hive.dart';

class GroceryLocal {
  static final instance=GroceryLocal._internal();
  GroceryLocal._internal();
  Box _groceryBox = Hive.box(LSKeyGroceryBox);
  Box get groceryBox =>_groceryBox;
  addItem(Map item) {
    List _groceryList =
        _groceryBox.get(LSKeyGroceryList, defaultValue: []);
    _groceryList.add(item);
    _groceryBox.put(LSKeyGroceryList, _groceryList);
  }

  updateItem(int index, Map item) {
    List _groceryList =
        _groceryBox.get(LSKeyGroceryList, defaultValue: []);
    _groceryList[index] = item;
    _groceryBox.put(LSKeyGroceryList, _groceryList);
  }

  removeItem(int index) {
    List _groceryList =
        _groceryBox.get(LSKeyGroceryList, defaultValue: []);
    _groceryList.removeAt(index);
    _groceryBox.put(LSKeyGroceryList, _groceryList);
  }
}
