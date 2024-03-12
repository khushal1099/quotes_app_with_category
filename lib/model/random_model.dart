// To parse this JSON data, do
//
//     final randomQuote = randomQuoteFromJson(jsonString);

import 'dart:convert';

List<RandomQuote> randomQuoteFromJson(String str) => List<RandomQuote>.from(json.decode(str).map((x) => RandomQuote.fromJson(x)));

String randomQuoteToJson(List<RandomQuote> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomQuote {
  String? id;
  String? content;
  String? author;
  List<String>? tags;
  String? authorSlug;
  int? length;
  DateTime? dateAdded;
  DateTime? dateModified;

  RandomQuote({
    this.id,
    this.content,
    this.author,
    this.tags,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  factory RandomQuote.fromJson(Map<String, dynamic> json) => RandomQuote(
    id: json["_id"],
    content: json["content"],
    author: json["author"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    authorSlug: json["authorSlug"],
    length: json["length"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "author": author,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "authorSlug": authorSlug,
    "length": length,
    "dateAdded": "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}
