import 'package:myfood/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfood/models/recipe.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myfood/view/Menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:myfood/models/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:myfood/app/services/api_keys.dart';

class MenuDetail extends StatelessWidget {
  final FindRecipes findRecipes;
  MenuDetail({required this.findRecipes});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: APIManager().getDetails(findRecipes.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                RecipeDetail data = snapshot.data as RecipeDetail;
                return SlidingUpPanel(
                  minHeight: deviceHeight / 2,
                  maxHeight: deviceHeight / 1.2,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  parallaxEnabled: true,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: ClipRRect(
                                //borderRadius: BorderRadius.circular(24),
                                child: Hero(
                                  tag: findRecipes.image,
                                  child: Image(
                                      height: (deviceHeight / 2) + 50,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(findRecipes.image)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 20,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      //border: Border.all(width: 3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  margin: EdgeInsets.only(
                                      right: deviceWidth * .75,
                                      top: deviceHeight * .05),
                                  width: deviceWidth * .15,
                                  height: deviceHeight * .045,
                                  child: Center(
                                    child: Text(
                                      "Back",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          //fontSize: deviceWidth * .03,
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  panel: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          findRecipes.title,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              IconData(0xe6e3, fontFamily: 'MaterialIcons'),
                              //color: Colors.deepOrange,
                              color: Color.fromRGBO(229, 115, 44, 1.0),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text((data.nutrition.nutrients[0].amount)
                                .toStringAsFixed(0)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              IconData(0xe662, fontFamily: 'MaterialIcons'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //Text(findRecipes.time),
                            Text(
                                "${data.readyInMinutes.toStringAsFixed(0)} Minutes")
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: 3,
                            initialIndex: 0,
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: Colors.black,
                                  indicator: DotIndicator(
                                      color: Color.fromRGBO(229, 115, 44, 1.0),
                                      distanceFromCenter: 16,
                                      radius: 3,
                                      paintingStyle: PaintingStyle.fill),
                                  unselectedLabelColor:
                                      Colors.black.withOpacity(0.3),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                  labelPadding: EdgeInsets.symmetric(),
                                  tabs: [
                                    Tab(
                                      text: "Ingredients",
                                    ),
                                    Tab(
                                      text: "Steps",
                                    ),
                                    Tab(
                                      text: "Equipment",
                                    )
                                  ],
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                                Expanded(
                                    child: TabBarView(
                                  children: [
                                    Ingredients(data: data),
                                    Steps(data: data),
                                    Equipment(data: data),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class Ingredients extends StatelessWidget {
  final RecipeDetail data;
  Ingredients({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text(
                      String.fromCharCode(0x2022),
                      style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      //color: Colors.amber,
                      //width: deviceWidth,
                      //child: Text(findRecipes.ingredients[index],
                      child:
                          Text(data.extendedIngredients[index].originalString,
                              maxLines: 5,
                              //softWrap: true,
                              overflow: TextOverflow.visible,
                              style: new TextStyle(
                                fontSize: 15,
                              )),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
              itemCount: data.extendedIngredients.length)
        ],
      ),
    );
  }
}

class Steps extends StatelessWidget {
  final RecipeDetail data;
  Steps({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.analyzedInstructions.isEmpty) {
      return Text("NA");
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text("Step " + (index + 1).toString()),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      //color: Colors.amber,
                      //width: deviceWidth,
                      child: Text(
                        data.analyzedInstructions[0].steps[index].step,
                        //maxLines: 5,
                        //softWrap: true,
                        //overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
              itemCount: data.analyzedInstructions[0].steps.length)
        ],
      ),
    );
  }
}

class Equipment extends StatelessWidget {
  final RecipeDetail data;
  final Map equipment = {};

  Equipment({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Map equipment = {};
    if (data.analyzedInstructions.isEmpty) {
      return Text("NA");
    }
    for (var i in data.analyzedInstructions[0].steps) {
      //if (data.analyzedInstructions[0].steps[i].equipment.isEmpty) {
      //  equipment[i] = "Hi";
      //  continue;
      //} else {
      //  equipment[i] = data.analyzedInstructions[0].steps[i].equipment[i].name;
      //}
      if (i.equipment.isEmpty) {
        //equipment[i] = "HI";
        continue;
      } else {
        equipment[i.equipment[0].name] = i.equipment[0].name;

        print(equipment);
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text(
                      String.fromCharCode(0x2022),
                      style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      //color: Colors.amber,
                      //width: deviceWidth,
                      child: Text(
                        (equipment.keys.elementAt(index).toString())[0]
                                .toUpperCase() +
                            equipment.keys
                                .elementAt(index)
                                .toString()
                                .substring(1),
                        maxLines: 5,
                        //softWrap: true,
                        overflow: TextOverflow.visible,
                        style: new TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black.withOpacity(0.3));
              },
              itemCount: equipment.length)
        ],
      ),
    );
  }
}
