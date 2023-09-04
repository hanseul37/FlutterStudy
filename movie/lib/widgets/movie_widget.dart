import 'package:flutter/material.dart';
import 'package:movie/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, posterPath, backdropPath, overview, releaseDate;
  final int id;
  final double voteAverage;

  const Movie({
    super.key,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              backdropPath: backdropPath,
              overview: overview,
              releaseDate: releaseDate,
              id: id,
              voteAverage: voteAverage,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ]),
              child:
                  Image.network('https://image.tmdb.org/t/p/w500$posterPath'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 150,
            child: Text(
              title,
              softWrap: true,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
