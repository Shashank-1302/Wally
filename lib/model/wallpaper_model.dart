class WallpaperModel {
  String? url;
  String? photographer;
  String? photographer_Url;
  int? photographer_Id;
  SrcModel? src;

  WallpaperModel(
      {this.url,
      this.photographer,
      this.photographer_Id,
      this.photographer_Url,
      this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> parsedJson) {
    return WallpaperModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographer_Id: parsedJson["photographer_id"],
        photographer_Url: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String? portrait;
  String? original;
  String? small;

  SrcModel({this.portrait, this.small, this.original});

  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        small: srcJson["small"],
        original: srcJson["original"]);
  }
}
