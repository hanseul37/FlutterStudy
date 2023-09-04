class MovieDetailModel {
  final String title, overview, releaseDate;
  final double voteAverage;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'];
}
