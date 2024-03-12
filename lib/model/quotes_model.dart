// To parse this JSON data, do
//
//     final quotes = quotesFromJson(jsonString);

import 'dart:convert';

List<Quotes> quotesFromJson(String str) => List<Quotes>.from(json.decode(str).map((x) => Quotes.fromJson(x)));

String quotesToJson(List<Quotes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quotes {
  List<String>? categories;
  String? loveImage;
  List<String>? love;
  String? calmImage;
  List<String>? calm;
  String? sadImage;
  List<String>? sad;
  String? timeImage;
  List<String>? time;
  String? futureImage;
  List<String>? future;
  String? relationshipImage;
  List<String>? relationship;

  Quotes({
    this.categories,
    this.loveImage,
    this.love,
    this.calmImage,
    this.calm,
    this.sadImage,
    this.sad,
    this.timeImage,
    this.time,
    this.futureImage,
    this.future,
    this.relationshipImage,
    this.relationship,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    loveImage: json["love_image"],
    love: json["Love"] == null ? [] : List<String>.from(json["Love"]!.map((x) => x)),
    calmImage: json["calm_image"],
    calm: json["Calm"] == null ? [] : List<String>.from(json["Calm"]!.map((x) => x)),
    sadImage: json["sad_image"],
    sad: json["Sad"] == null ? [] : List<String>.from(json["Sad"]!.map((x) => x)),
    timeImage: json["time_image"],
    time: json["Time"] == null ? [] : List<String>.from(json["Time"]!.map((x) => x)),
    futureImage: json["future_image"],
    future: json["Future"] == null ? [] : List<String>.from(json["Future"]!.map((x) => x)),
    relationshipImage: json["relationship_image"],
    relationship: json["Relationship"] == null ? [] : List<String>.from(json["Relationship"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "love_image": loveImage,
    "Love": love == null ? [] : List<dynamic>.from(love!.map((x) => x)),
    "calm_image": calmImage,
    "Calm": calm == null ? [] : List<dynamic>.from(calm!.map((x) => x)),
    "sad_image": sadImage,
    "Sad": sad == null ? [] : List<dynamic>.from(sad!.map((x) => x)),
    "time_image": timeImage,
    "Time": time == null ? [] : List<dynamic>.from(time!.map((x) => x)),
    "future_image": futureImage,
    "Future": future == null ? [] : List<dynamic>.from(future!.map((x) => x)),
    "relationship_image": relationshipImage,
    "Relationship": relationship == null ? [] : List<dynamic>.from(relationship!.map((x) => x)),
  };
}
