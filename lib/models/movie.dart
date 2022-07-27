import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final double vote_average;
  String overview;
  String poster_path;
  String backdrop_path;
  String original_language;
  double popularity;
  String release_date;

  Movie(
      this.id,
      this.title,
      this.vote_average,
      this.overview,
      this.poster_path,
      this.backdrop_path,
      this.original_language,
      this.popularity,
      this.release_date);

  posterPath() {
    String baseUrl = "https://image.tmdb.org/t/p/w500/";
    return baseUrl + poster_path;
  }

  backdropPath() {
    String baseUrl = "https://image.tmdb.org/t/p/w500/";
    return baseUrl + backdrop_path;
  }

  capsLanguage() {
    return original_language.toUpperCase();
  }

  double getRating() {
    String inString = vote_average.toStringAsFixed(1); // '2.31'
    double inDouble = double.parse(inString);
    return inDouble;
  }

  String getYearOfRelease() {
    String year = "";
    if (release_date != "") {
      year = release_date.substring(0, 4);
    }
    return year;
  }

  Movie copyWith({
    int? id,
    String? title,
    double? vote_average,
    String? overview,
    String? poster_path,
    String? backdrop_path,
    String? original_language,
    double? popularity,
    String? release_date,
  }) {
    return Movie(
      id ?? this.id,
      title ?? this.title,
      vote_average ?? this.vote_average,
      overview ?? this.overview,
      poster_path ?? this.poster_path,
      backdrop_path ?? this.backdrop_path,
      original_language ?? this.original_language,
      popularity ?? this.popularity,
      release_date ?? this.release_date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'vote_average': vote_average,
      'overview': overview,
      'poster_path': poster_path,
      'backdrop_path': backdrop_path,
      'original_language': original_language,
      'popularity': popularity,
      'release_date': release_date,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      map['id']?.toInt() ?? 0,
      map['title'] ?? '',
      map['vote_average']?.toDouble() ?? 0.0,
      map['overview'] ?? '',
      map['poster_path'] ?? '',
      map['backdrop_path'] ?? '',
      map['original_language'] ?? '',
      map['popularity']?.toDouble() ?? 0.0,
      map['release_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, vote_average: $vote_average, overview: $overview, poster_path: $poster_path, backdrop_path: $backdrop_path, original_language: $original_language, popularity: $popularity, release_date: $release_date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.id == id &&
        other.title == title &&
        other.vote_average == vote_average &&
        other.overview == overview &&
        other.poster_path == poster_path &&
        other.backdrop_path == backdrop_path &&
        other.original_language == original_language &&
        other.popularity == popularity &&
        other.release_date == release_date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        vote_average.hashCode ^
        overview.hashCode ^
        poster_path.hashCode ^
        backdrop_path.hashCode ^
        original_language.hashCode ^
        popularity.hashCode ^
        release_date.hashCode;
  }
}
