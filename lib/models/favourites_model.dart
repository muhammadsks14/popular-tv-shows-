class FavouriteModel {
  String? movieId;
  String? name;
  String? date;
  String? rating;
  String? language;
  String? description;

  FavouriteModel(
      {this.name,
      this.description,
      this.date,
      this.language,
      this.movieId,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'movieId': movieId,
      'date': date,
      'rating': rating,
      'language': language,
      'description': description,
    };
  }
}
