// To parse this JSON data, do
//
//     final bibleTamil = bibleTamilFromJson(jsonString);

import 'dart:convert';

Map<String, BibleTamil> bibleTamilFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, BibleTamil>(k, BibleTamil.fromJson(v)));

String bibleTamilToJson(Map<String, BibleTamil> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class BibleTamil {
  Book? book;
  String? count;
  List<Chapter>? chapters;

  BibleTamil({
    this.book,
    this.count,
    this.chapters,
  });

  factory BibleTamil.fromJson(Map<String, dynamic> json) => BibleTamil(
    book: json["book"] == null ? null : Book.fromJson(json["book"]),
    count: json["count"],
    chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "book": book?.toJson(),
    "count": count,
    "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
  };
}

class Book {
  String? english;
  String? tamil;

  Book({
    this.english,
    this.tamil,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    english: json["english"],
    tamil: json["tamil"],
  );

  Map<String, dynamic> toJson() => {
    "english": english,
    "tamil": tamil,
  };
}

class Chapter {
  String? chapter;
  List<Verse>? verses;

  Chapter({
    this.chapter,
    this.verses,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    chapter: json["chapter"],
    verses: json["verses"] == null ? [] : List<Verse>.from(json["verses"]!.map((x) => Verse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter": chapter,
    "verses": verses == null ? [] : List<dynamic>.from(verses!.map((x) => x.toJson())),
  };
}

class Verse {
  String? verse;
  String? text;

  Verse({
    this.verse,
    this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    verse: json["verse"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "verse": verse,
    "text": text,
  };
}
