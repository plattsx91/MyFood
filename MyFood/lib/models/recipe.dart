import 'dart:convert';

class RecipeModel {
  final String title;
  final double rating;
  final double calories;
  final String uri;
  final String time;
  final List ingredients;
  final List steps;
  final List equipment;

  RecipeModel(this.title, this.rating, this.calories, this.time, this.uri,
      this.ingredients, this.steps, this.equipment);
}
// To parse this JSON data, do
//
//     final findRecipes = findRecipesFromJson(jsonString);

List<FindRecipes> findRecipesFromJson(String str) => List<FindRecipes>.from(
    json.decode(str).map((x) => FindRecipes.fromJson(x)));

String findRecipesToJson(List<FindRecipes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FindRecipes {
  FindRecipes({
    required this.id,
    required this.image,
    //required this.imageType,
    required this.likes,
    //required this.missedIngredientCount,
    //required this.missedIngredients,
    required this.title,
    //required this.unusedIngredients,
    //required this.usedIngredientCount,
    //required this.usedIngredients,
  });

  int id;
  String image;
  //String imageType;
  int likes;
  //int missedIngredientCount;
  //List<SedIngredient> missedIngredients;
  String title;
  //List<SedIngredient> unusedIngredients;
  //int usedIngredientCount;
  //List<SedIngredient> usedIngredients;
  //factory FindRecipes.fromRawJson(String str) =>
  //    FindRecipes.fromJson(json.decode(str));

  //String toRawJson() => json.encode(toJson());

  factory FindRecipes.fromJson(Map<String, dynamic> json) => FindRecipes(
        id: json["id"],
        image: json["image"],
        //imageType: json["imageType"],
        likes: json["likes"],
        //missedIngredientCount: json["missedIngredientCount"],
        //missedIngredients: List<SedIngredient>.from(
        //    json["missedIngredients"].map((x) => SedIngredient.fromJson(x))),
        title: json["title"],
        //unusedIngredients: List<SedIngredient>.from(
        //    json["unusedIngredients"].map((x) => SedIngredient.fromJson(x))),
        //usedIngredientCount: json["usedIngredientCount"],
        //usedIngredients: List<SedIngredient>.from(
        //    json["usedIngredients"].map((x) => SedIngredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        //"imageType": imageType,
        "likes": likes,
        //"missedIngredientCount": missedIngredientCount,
        //"missedIngredients":
        //    List<dynamic>.from(missedIngredients.map((x) => x.toJson())),
        "title": title,
        //  "unusedIngredients":
        //      List<dynamic>.from(unusedIngredients.map((x) => x.toJson())),
        //  "usedIngredientCount": usedIngredientCount,
        //  "usedIngredients":
        //      List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
      };
}

//class SedIngredient {
//  SedIngredient({
//    required this.aisle,
//    required this.amount,
//    required this.id,
//    required this.image,
//    required this.meta,
//    required this.name,
//    required this.original,
//    required this.originalName,
//    required this.unit,
//    required this.unitLong,
//    required this.unitShort,
//    required this.extendedName,
//  });

//  String aisle;
//  double amount;
//  int id;
//  String image;
//  List<String> meta;
//  String name;
//  String original;
//  String originalName;
//  String unit;
//  String unitLong;
//  String unitShort;
//  String extendedName;

//  factory SedIngredient.fromJson(Map<String, dynamic> json) => SedIngredient(
//        aisle: json["aisle"],
//        amount: json["amount"].toDouble(),
//        id: json["id"],
//        image: json["image"],
//        meta: List<String>.from(json["meta"].map((x) => x)),
//        name: json["name"],
//        original: json["original"],
//        originalName: json["originalName"],
//        unit: json["unit"],
//        unitLong: json["unitLong"],
//        unitShort: json["unitShort"],
//        extendedName:
//            json["extendedName"] == null ? null : json["extendedName"],
//      );

//  Map<String, dynamic> toJson() => {
//        "aisle": aisle,
//        "amount": amount,
//        "id": id,
//        "image": image,
//        "meta": List<dynamic>.from(meta.map((x) => x)),
//        "name": name,
//        "original": original,
//        "originalName": originalName,
//        "unit": unit,
//        "unitLong": unitLong,
//        "unitShort": unitShort,
//        "extendedName": extendedName == null ? null : extendedName,
//      };
//}
// To parse this JSON data, do
//
//     final findRecipes = findRecipesFromJson(jsonString);

//import 'dart:convert';

//List<FindRecipes> findRecipesFromJson(String str) => List<FindRecipes>.from(json.decode(str).map((x) => FindRecipes.fromJson(x)));

//String findRecipesToJson(List<FindRecipes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

//class FindRecipes {
//    FindRecipes({
//        this.id,
//        this.image,
//        this.imageType,
//        this.likes,
//        this.missedIngredientCount,
//        this.missedIngredients,
//        this.title,
//        this.unusedIngredients,
//        this.usedIngredientCount,
//        this.usedIngredients,
//    });

//    int id;
//    String image;
//    String imageType;
//    int likes;
//    int missedIngredientCount;
//    List<SedIngredient> missedIngredients;
//    String title;
//    List<SedIngredient> unusedIngredients;
//    int usedIngredientCount;
//    List<SedIngredient> usedIngredients;

//    factory FindRecipes.fromJson(Map<String, dynamic> json) => FindRecipes(
//        id: json["id"],
//        image: json["image"],
//        imageType: json["imageType"],
//        likes: json["likes"],
//        missedIngredientCount: json["missedIngredientCount"],
//        missedIngredients: List<SedIngredient>.from(json["missedIngredients"].map((x) => SedIngredient.fromJson(x))),
//        title: json["title"],
//        unusedIngredients: List<SedIngredient>.from(json["unusedIngredients"].map((x) => SedIngredient.fromJson(x))),
//        usedIngredientCount: json["usedIngredientCount"],
//        usedIngredients: List<SedIngredient>.from(json["usedIngredients"].map((x) => SedIngredient.fromJson(x))),
//    );

//    Map<String, dynamic> toJson() => {
//        "id": id,
//        "image": image,
//        "imageType": imageType,
//        "likes": likes,
//        "missedIngredientCount": missedIngredientCount,
//        "missedIngredients": List<dynamic>.from(missedIngredients.map((x) => x.toJson())),
//        "title": title,
//        "unusedIngredients": List<dynamic>.from(unusedIngredients.map((x) => x.toJson())),
//        "usedIngredientCount": usedIngredientCount,
//        "usedIngredients": List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
//    };
//}

//class SedIngredient {
//    SedIngredient({
//        this.aisle,
//        this.amount,
//        this.id,
//        this.image,
//        this.meta,
//        this.name,
//        this.original,
//        this.originalName,
//        this.unit,
//        this.unitLong,
//        this.unitShort,
//        this.extendedName,
//    });

//    String aisle;
//    double amount;
//    int id;
//    String image;
//    List<String> meta;
//    String name;
//    String original;
//    String originalName;
//    String unit;
//    String unitLong;
//    String unitShort;
//    String extendedName;

//    factory SedIngredient.fromJson(Map<String, dynamic> json) => SedIngredient(
//        aisle: json["aisle"],
//        amount: json["amount"].toDouble(),
//        id: json["id"],
//        image: json["image"],
//        meta: List<String>.from(json["meta"].map((x) => x)),
//        name: json["name"],
//        original: json["original"],
//        originalName: json["originalName"],
//        unit: json["unit"],
//        unitLong: json["unitLong"],
//        unitShort: json["unitShort"],
//        extendedName: json["extendedName"] == null ? null : json["extendedName"],
//    );

//    Map<String, dynamic> toJson() => {
//        "aisle": aisle,
//        "amount": amount,
//        "id": id,
//        "image": image,
//        "meta": List<dynamic>.from(meta.map((x) => x)),
//        "name": name,
//        "original": original,
//        "originalName": originalName,
//        "unit": unit,
//        "unitLong": unitLong,
//        "unitShort": unitShort,
//        "extendedName": extendedName == null ? null : extendedName,
//    };
//}
