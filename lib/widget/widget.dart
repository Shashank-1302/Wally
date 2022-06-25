import 'package:flutter/material.dart';
import 'package:wally/views/image_view.dart';

import '../model/wallpaper_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text(
        "Wal",
        style: TextStyle(
            color: Colors.white, fontFamily: 'PermanentMarker', fontSize: 30),
      ),
      Text(
        "ly",
        style: TextStyle(
            color: Colors.blue, fontFamily: 'PermanentMarker', fontSize: 30),
      )
    ],
  );
}

Widget wallPaperList(List<WallpaperModel> wallpapers, context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((WallpaperModel wallpaperModel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgURL: wallpaperModel.src!.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaperModel.src!.portrait!,
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        wallpaperModel.src!.portrait!,
                        fit: BoxFit.cover,
                      ))),
            ),
          ));
        }).toList()),
  );
}
