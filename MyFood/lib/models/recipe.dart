import 'dart:convert';

import 'package:flutter/material.dart';

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

//List<FindRecipes> findRecipesFromJson(String str) => List<FindRecipes>.from(
//    json.decode(str).map((x) => FindRecipes.fromJson(x)));

//String findRecipesToJson(List<FindRecipes> data) =>
//    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FindRecipes {
  FindRecipes({
    required this.id,
    required this.image,
    //required this.imageType,
    required this.likes,
    //required this.missedIngredientCount,
    //required this.missedIngredients,
    required this.title,
    //required this.nutrition,

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
  //Nutrition nutrition;

  //List<SedIngredient> unusedIngredients;
  //int usedIngredientCount;
  //List<SedIngredient> usedIngredients;
  //factory FindRecipes.fromRawJson(String str) =>
  //    FindRecipes.fromJson(json.decode(str));

  //String toRawJson() => json.encode(toJson());
  List<FindRecipes> findRecipesFromJson(String str) => List<FindRecipes>.from(
      json.decode(str).map((x) => FindRecipes.fromJson(x)));

  String findRecipesToJson(List<FindRecipes> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory FindRecipes.fromJson(Map<String, dynamic> json) => FindRecipes(
        id: json["id"],
        image: json["image"],
        //imageType: json["imageType"],
        likes: json["likes"],
        //missedIngredientCount: json["missedIngredientCount"],
        //missedIngredients: List<SedIngredient>.from(
        //    json["missedIngredients"].map((x) => SedIngredient.fromJson(x))),
        title: json["title"],
        //nutrition: Nutrition.fromJson(json["nutrition"]),

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
        //"nutrition": nutrition.toJson(),

        //  "unusedIngredients":
        //      List<dynamic>.from(unusedIngredients.map((x) => x.toJson())),
        //  "usedIngredientCount": usedIngredientCount,
        //  "usedIngredients":
        //      List<dynamic>.from(usedIngredients.map((x) => x.toJson())),
      };
}
// To parse this JSON data, do
//
//     final recipeDetail = recipeDetailFromJson(jsonString);

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final recipeDetail = recipeDetailFromJson(jsonString);

RecipeDetail recipeDetailFromJson(String str) =>
    RecipeDetail.fromJson(json.decode(str));

String recipeDetailToJson(RecipeDetail data) => json.encode(data.toJson());

class RecipeDetail {
  RecipeDetail(
      {
      //this.vegetarian,
      //this.vegan,
      //this.glutenFree,
      //this.dairyFree,
      //this.veryHealthy,
      //this.cheap,
      //this.veryPopular,
      //this.sustainable,
      //this.weightWatcherSmartPoints,
      //this.gaps,
      //this.lowFodmap,
      //this.aggregateLikes,
      //this.spoonacularScore,
      //this.healthScore,
      //this.creditsText,
      //this.license,
      //this.sourceName,
      //this.pricePerServing,
      required this.extendedIngredients,
      required this.id,
      required this.title,
      required this.readyInMinutes,
      required this.nutrition,
      //required this.instructions,
      required this.analyzedInstructions});

  //bool vegetarian;
  //bool vegan;
  //bool glutenFree;
  //bool dairyFree;
  //bool veryHealthy;
  //bool cheap;
  //bool veryPopular;
  //bool sustainable;
  //int weightWatcherSmartPoints;
  //String gaps;
  //bool lowFodmap;
  //int aggregateLikes;
  //int spoonacularScore;
  //int healthScore;
  //String creditsText;
  //String license;
  //String sourceName;
  //double pricePerServing;
  List<ExtendedIngredient> extendedIngredients;
  int id;
  String title;
  int readyInMinutes;
  //int servings;
  //String sourceUrl;
  //String image;
  //String imageType;
  Nutrition nutrition;
  //String instructions;
  List<AnalyzedInstruction> analyzedInstructions;

  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
        //vegetarian: json["vegetarian"],
        //vegan: json["vegan"],
        //glutenFree: json["glutenFree"],
        //dairyFree: json["dairyFree"],
        //veryHealthy: json["veryHealthy"],
        //cheap: json["cheap"],
        //veryPopular: json["veryPopular"],
        //sustainable: json["sustainable"],
        //weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        //gaps: json["gaps"],
        //lowFodmap: json["lowFodmap"],
        //aggregateLikes: json["aggregateLikes"],
        //spoonacularScore: json["spoonacularScore"],
        //healthScore: json["healthScore"],
        //creditsText: json["creditsText"],
        //license: json["license"],
        //sourceName: json["sourceName"],
        //pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients: List<ExtendedIngredient>.from(
            json["extendedIngredients"]
                .map((x) => ExtendedIngredient.fromJson(x))),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        //servings: json["servings"],
        //sourceUrl: json["sourceUrl"],
        //image: json["image"],
        //imageType: json["imageType"],
        nutrition: Nutrition.fromJson(json["nutrition"]),
        //instructions: json["instructions"],
        analyzedInstructions: List<AnalyzedInstruction>.from(
            json["analyzedInstructions"]
                .map((x) => AnalyzedInstruction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        //"vegetarian": vegetarian,
        //"vegan": vegan,
        //"glutenFree": glutenFree,
        //"dairyFree": dairyFree,
        //"veryHealthy": veryHealthy,
        //"cheap": cheap,
        //"veryPopular": veryPopular,
        //"sustainable": sustainable,
        //"weightWatcherSmartPoints": weightWatcherSmartPoints,
        //"gaps": gaps,
        //"lowFodmap": lowFodmap,
        //"aggregateLikes": aggregateLikes,
        //"spoonacularScore": spoonacularScore,
        //"healthScore": healthScore,
        //"creditsText": creditsText,
        //"license": license,
        //"sourceName": sourceName,
        //"pricePerServing": pricePerServing,
        "extendedIngredients":
            List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        //"servings": servings,
        //"sourceUrl": sourceUrl,
        //"image": image,
        //"imageType": imageType,
        "nutrition": nutrition.toJson(),
        //"instructions": instructions,
        "analyzedInstructions":
            List<dynamic>.from(analyzedInstructions.map((x) => x.toJson())),
      };
}

class AnalyzedInstruction {
  AnalyzedInstruction({
    required this.name,
    required this.steps,
  });

  String name;
  List<Step> steps;

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      AnalyzedInstruction(
        name: json["name"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Step {
  Step({
    required this.number,
    required this.step,
    required this.equipment,
    //this.ingredients,
  });

  int number;
  String step;
  List<Equipment> equipment;
  factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        equipment: List<Equipment>.from(
            json["equipment"].map((x) => Equipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "step": step,
        "equipment": List<dynamic>.from(equipment.map((x) => x.toJson())),
      };
}

class Equipment {
  Equipment({
    //this.id,
    required this.name,
    //this.localizedName,
    //this.image,
  });

  //int id;
  String name;
  //String localizedName;
  //String image;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        //id: json["id"],
        name: json["name"],
        //localizedName: json["localizedName"],
        //image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "name": name,
        //"localizedName": localizedName,
        //"image": image,
      };
}

class ExtendedIngredient {
  ExtendedIngredient({
    //this.id,
    //this.aisle,
    //this.image,
    //this.consistency,
    //this.name,
    //this.nameClean,
    //this.original,
    required this.originalString,
    //this.originalName,
  });

  //int id;
  //String aisle;
  //String image;
  //String consistency;
  //String name;
  //String nameClean;
  //String original;
  String originalString;
  //String originalName;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        //id: json["id"],
        //aisle: json["aisle"],
        //image: json["image"],
        //consistency: json["consistency"],
        //name: json["name"],
        //nameClean: json["nameClean"],
        //original: json["original"],
        originalString: json["originalString"],
        //originalName: json["originalName"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        //"aisle": aisle,
        //"image": image,
        //"consistency": consistency,
        //"name": name,
        //"nameClean": nameClean,
        //"original": original,
        "originalString": originalString,
        //"originalName": originalName,
      };
}

class Nutrition {
  Nutrition({
    required this.nutrients,
  });

  List<Nutrient> nutrients;

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        nutrients: List<Nutrient>.from(
            json["nutrients"].map((x) => Nutrient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nutrients": List<dynamic>.from(nutrients.map((x) => x.toJson())),
      };
}

class Nutrient {
  Nutrient({
    required this.title,
    required this.amount,
  });

  //String name;
  String title;
  double amount;
  //String unit;
  //double percentOfDailyNeeds;

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        title: json["title"],
        amount: json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "amount": amount,
      };
}

class FullRecipe {
  FullRecipe({
    required this.cardList,
    required this.recipeList,
  });

  List<FindRecipes> cardList;
  List<RecipeDetail> recipeList;
}
