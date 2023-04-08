import 'package:app/module/user/models/meals/dashboard_meals_model.dart';

class MealDashboard {
  String? status;
  String? responseCode;
  String? responseDescription;
  ResponseDetails? responseDetails;

  MealDashboard(
      {this.status,
      this.responseCode,
      this.responseDescription,
      this.responseDetails});

  MealDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    responseDescription = json['responseDescription'];
    responseDetails = json['responseDetails'] != null
        ? new ResponseDetails.fromJson(json['responseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['responseDescription'] = this.responseDescription;
    if (this.responseDetails != null) {
      data['responseDetails'] = this.responseDetails!.toJson();
    }
    return data;
  }
}

class ResponseDetails {
  MealPerDay? day1;
  MealPerDay? day2;
  MealPerDay? day3;
  MealPerDay? day4;
  MealPerDay? day5;
  MealPerDay? day6;
  MealPerDay? day7;

  ResponseDetails(
      {this.day1,
      this.day2,
      this.day3,
      this.day4,
      this.day5,
      this.day6,
      this.day7});

  ResponseDetails.fromJson(Map<String, dynamic> json) {
    day1 = json['1'] != null ? new MealPerDay.fromJson(json['1']) : null;
    day2 = json['2'] != null ? new MealPerDay.fromJson(json['2']) : null;
    day3 = json['3'] != null ? new MealPerDay.fromJson(json['3']) : null;
    day4 = json['4'] != null ? new MealPerDay.fromJson(json['4']) : null;
    day5 = json['5'] != null ? new MealPerDay.fromJson(json['5']) : null;
    day6 = json['6'] != null ? new MealPerDay.fromJson(json['6']) : null;
    day7 = json['7'] != null ? new MealPerDay.fromJson(json['7']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.day1 != null) {
      data['1'] = this.day1!.toJson();
    }
    if (this.day2 != null) {
      data['2'] = this.day2!.toJson();
    }
    if (this.day3 != null) {
      data['3'] = this.day3!.toJson();
    }
    if (this.day4 != null) {
      data['4'] = this.day4!.toJson();
    }
    if (this.day5 != null) {
      data['5'] = this.day5!.toJson();
    }
    if (this.day6 != null) {
      data['6'] = this.day6!.toJson();
    }
    if (this.day7 != null) {
      data['7'] = this.day7!.toJson();
    }
    return data;
  }
}

class MealPerDay {
  List<Meal>? snack;
  List<Meal>? breakfast;
  List<Meal>? lunch;
  List<Meal>? dinner = <Meal>[];
  List<Meal>? mainMeal = <Meal>[];

  MealPerDay(
      {this.snack, this.breakfast, this.lunch, this.dinner, this.mainMeal});

  MealPerDay.fromJson(Map<String, dynamic> json) {
    if (json['Snack'] != null) {
      snack = <Meal>[];
      json['Snack'].forEach((v) {
        snack!.add(new Meal.fromJson(v));
      });
    }
    if (json['Breakfast'] != null) {
      breakfast = <Meal>[];
      json['Breakfast'].forEach((v) {
        breakfast!.add(new Meal.fromJson(v));
      });
    }

    if (json['Lunch'] != null) {
      lunch = <Meal>[];
      json['Lunch'].forEach((v) {
        lunch!.add(new Meal.fromJson(v));
      });
    }

    if (json['Dinner'] != null) {
      dinner = <Meal>[];
      json['Dinner'].forEach((v) {
        dinner!.add(new Meal.fromJson(v));
      });
    }
    if (json['Main Meal'] != null) {
      mainMeal = <Meal>[];
      json['Main Meal'].forEach((v) {
        mainMeal!.add(new Meal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.snack != null) {
      data['Snack'] = this.snack!.map((v) => v.toJson()).toList();
    }
    if (this.breakfast != null) {
      data['Breakfast'] = this.breakfast!.map((v) => v.toJson()).toList();
    }
    if (this.lunch != null) {
      data['Lunch'] = this.lunch!.map((v) => v.toJson()).toList();
    }
    if (this.dinner != null) {
      data['Dinner'] = this.dinner!.map((v) => v.toJson()).toList();
    }
    if (this.mainMeal != null) {
      data['Main Meal'] = this.mainMeal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? favoriteMealId;
  int? id;
  String? name;
  int? quantity;
  String? type;
  int? proteins;
  int? carbs;
  int? fats;
  String? mealIngredientInfo;
  int? calories;

  Ingredients(
      {this.favoriteMealId,
      this.id,
      this.name,
      this.quantity,
      this.type,
      this.proteins,
      this.carbs,
      this.fats,
      this.mealIngredientInfo,
      this.calories});

  Ingredients.fromJson(Map<String, dynamic> json) {
    favoriteMealId = json['favoriteMealId'];
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    type = json['type'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    mealIngredientInfo = json['MealIngredientInfo'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favoriteMealId'] = this.favoriteMealId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['type'] = this.type;
    data['proteins'] = this.proteins;
    data['carbs'] = this.carbs;
    data['fats'] = this.fats;
    data['MealIngredientInfo'] = this.mealIngredientInfo;
    data['calories'] = this.calories;
    return data;
  }
}

class Breakfast {
  int? userId;
  int? id;
  int? restaurantId;
  String? imageUrl;
  String? title;
  String? mealType;
  String? mealLevel;
  int? calories;
  int? proteins;
  int? carbs;
  int? fats;
  String? method;
  List<Ingredients>? ingredients;

  Breakfast(
      {this.userId,
      this.id,
      this.restaurantId,
      this.imageUrl,
      this.title,
      this.mealType,
      this.mealLevel,
      this.calories,
      this.proteins,
      this.carbs,
      this.fats,
      this.method,
      this.ingredients});

  Breakfast.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    restaurantId = json['resturantId'];
    imageUrl = json['imageUrl'];
    title = json['title'];
    mealType = json['mealType'];
    mealLevel = json['mealLevel'];
    calories = json['calories'];
    proteins = json['proteins'];
    carbs = json['carbs'];
    fats = json['fats'];
    method = json['method'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['resturantId'] = this.restaurantId;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['mealType'] = this.mealType;
    data['mealLevel'] = this.mealLevel;
    data['calories'] = this.calories;
    data['proteins'] = this.proteins;
    data['carbs'] = this.carbs;
    data['fats'] = this.fats;
    data['method'] = this.method;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
