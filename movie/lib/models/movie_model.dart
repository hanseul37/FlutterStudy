class MovieModel {
  final String title, posterPath, backdropPath, overview, releaseDate;
  final int id;
  final double voteAverage;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'],
        overview = json['overview'],
        releaseDate = json['release_date'],
        id = json['id'],
        voteAverage = json['vote_average'].toDouble();
}
