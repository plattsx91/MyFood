import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myfood/models/recipe.dart';
import 'package:myfood/view/Menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIManager {
  Future<List<FindRecipes>> getRecipes() async {
    var client = http.Client();
    Future<List<String>> getDoc() async {
      List<String> docList = [];
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
          docList.add(doc["Name"]);
        });
      });
      return docList;
    }

    List<String> fridge = await getDoc();

    print(fridge);
    //List<String> fridge = ["apples,", "flour", "sugar"];
    int num = fridge.length;
    String ingred = fridge.join(',+');
    //const String API_KEY = "";
    //const String API_KEY = "dee8524179dc4fa0a540db9d7e5bea67"; // coval001
    //const String API_KEY = "10ab1b3d01ff4c5e8462cfd3639e25d9"; //chrisovalle1
    const String API_KEY = "97be04bf75fe4d8080ad7806416dc3cf"; //ovallelarry

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
      var recipeModel =
          jsonResponse.map((i) => new FindRecipes.fromJson(i)).toList();

      //List ids = [];
      //for (var j in recipeModel) {
      //  ids.add(j.id);
      //}
      //print(ids);
      //String iD = ids.join(",");
      //String request2 =
      //    'https://api.spoonacular.com/recipes/informationBulk?ids=';
      //request1 += iD + '&apiKey=' + API_KEY;
      //Uri uri2 = Uri.parse(request2);
      //var response2 = await client.get(uri2);
      //var recipeModel2 = [];
      //if (response2.statusCode == 200) {
      //  var jsonString2 = response2.body;
      //  List jsonResponse2 = json.decode(jsonString2);
      //  var recipeModel2 =
      //      jsonResponse2.map((i) => new RecipeDetail.fromJson(i)).toList();
      //}
      print(recipeModel);
      return recipeModel;
    } else {
      throw Exception();
    }
  }

  Future<RecipeDetail> getDetails(id) async {
    var client2 = http.Client();
    //const String API_KEY = "";
    //const String API_KEY = "dee8524179dc4fa0a540db9d7e5bea67"; // coval001
    //const String API_KEY = "10ab1b3d01ff4c5e8462cfd3639e25d9"; //chrisovalle1
    const String API_KEY = "97be04bf75fe4d8080ad7806416dc3cf"; //ovallelarry

    String request2 = 'https://api.spoonacular.com/recipes/';
    request2 += id.toString() +
        "/information?includeNutrition=true" +
        '&apiKey=' +
        API_KEY;
    Uri uri2 = Uri.parse(request2);
    var response2 = await client2.get(uri2);
    //var recipeModel2 = [];
    if (response2.statusCode == 200) {
      var jsonString2 = response2.body;
      var jsonResponse2 = json.decode(jsonString2);
      var recipeModel2 = RecipeDetail.fromJson(jsonResponse2);
      print(jsonString2);

      return recipeModel2;
    } else {
      throw Exception();
    }
  }
}
