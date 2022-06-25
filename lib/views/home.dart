import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wally/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:wally/model/wallpaper_model.dart';
import 'package:wally/views/category.dart';
import 'package:wally/views/image_view.dart';
import 'package:wally/views/search.dart';
import '../model/categories_model.dart';
import '../widget/widget.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController searchController = TextEditingController();
  //int counter = 0;
  getTrendingWallpapers() async {
    var url = Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=2");
    var response = await http.get(url, headers: {"Authorization": apiKEY});
    print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  /*void _increment() {
    setState(() {
      counter++;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: brandName(),
          backgroundColor: Color.fromARGB(249, 47, 47, 47),
          elevation: 0.0,
        ),
        backgroundColor: Color.fromARGB(249, 47, 47, 47),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 209, 214),
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "search wallpapers",
                        border: InputBorder.none),
                  )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(
                                    searchQuery: searchController.text,
                                  )));
                    },
                    child: Container(
                      child: Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Text(
              "Categories:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "PermanentMarker",
                  fontWeight: FontWeight.w400,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              height: 60,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoriesTile(
                    title: categories[index].categorieName,
                    imgUrl: categories[index].imgUrl,
                  );
                },
              ),
            ),
            Text(
              "Trendings:",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "PermanentMarker",
                  fontWeight: FontWeight.w400,
                  fontSize: 25),
            ),

            // FloatingActionButton(
            // onPressed: _increment,
            // tooltip: 'Refresh',
            // child: new Icon(Icons.refresh),
            //),
            wallPaperList(wallpapers, context),
          ]),
        )));
  }
}

class CategoriesTile extends StatelessWidget {
  final String? imgUrl, title;
  const CategoriesTile({this.imgUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Category(
                        categorieName: title!.toLowerCase(),
                      )));
        },
        child: Container(
            margin: EdgeInsets.only(right: 4),
            child: Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgUrl!,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  title!,
                  style: TextStyle(
                      fontFamily: 'PermanentMarker',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              )
            ])));
  }
}
