import 'dart:convert';

import 'package:flutter/foundation.dart';

class Movie {
  String title;
  int rating;
  List<String> cast;
  Movie({
    required this.title,
    required this.rating,
    required this.cast,
  });

  Movie copyWith({
    String? title,
    int? rating,
    List<String>? cast,
  }) {
    return Movie(
      title: title ?? this.title,
      rating: rating ?? this.rating,
      cast: cast ?? this.cast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'rating': rating,
      'cast': cast,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] ?? '',
      rating: map['rating']?.toInt() ?? 0,
      cast: List<String>.from(map['cast']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() => 'Movie(title: $title, rating: $rating, cast: $cast)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.rating == rating &&
        listEquals(other.cast, cast);
  }

  @override
  int get hashCode => title.hashCode ^ rating.hashCode ^ cast.hashCode;
}
