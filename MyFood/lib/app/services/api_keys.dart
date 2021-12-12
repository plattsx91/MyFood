import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myfood/models/recipe.dart';
import 'package:myfood/view/Menu.dart';
import 'dart:developer';
import 'package:path/path.dart' as Path;
import 'package:myfood/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfood/models/recipe.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myfood/view/MenuDetail.dart';
import 'package:myfood/app/services/api_keys.dart';
import 'package:path/path.dart';

class APIManager {
  Future<List<FindRecipes>> getRecipes() async {
    var client = http.Client();
    Future<List<QueryDocumentSnapshot>> getDoc() async {
      List<QueryDocumentSnapshot> docList = [];
      var db = FirebaseFirestore.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;

      await db
          .collection("Users")
          .doc(uid)
          .collection("Drawer")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          docList.add(doc);
        });
      });
      print(docList);
      return docList;
    }

    List<String> fridge = [];

    FutureBuilder(
        future: getDoc(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> data =
                snapshot.data as List<QueryDocumentSnapshot>;
            for (var i in data) {
              fridge.add(i["Name"]);
              //return Text(data[0].id);
            }
          }
          return Text("");
        });

    //List<String> fridge = ["apples,", "flour", "sugar"];
    int num = fridge.length;
    String ingred = fridge.join(',+');
    const String API_KEY = "dee8524179dc4fa0a540db9d7e5bea67";
    String request1 =
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=';
    request1 += ingred + '&number=' + num.toString() + '&apiKey=' + API_KEY;
    Uri uri = Uri.parse(request1);
    var response = await client.get(uri);
    //List<FindRecipes> recipeList = [];
    if (response.statusCode == 200) {
      var jsonString = response.body;
      List jsonResponse = json.decode(jsonString);
      //jsonResponse.map((job) => new FindRecipes.fromJson(job)).toList();
      //recipeList = list.map((i) => FindRecipes.fromJson(i)).toList();
      //recipeModel = FindRecipes.fromJson(jsonMap);
      return jsonResponse.map((job) => new FindRecipes.fromJson(job)).toList();
    } else {
      throw Exception();
    }
  }
}
