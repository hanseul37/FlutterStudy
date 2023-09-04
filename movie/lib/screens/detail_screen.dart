import 'package:flutter/material.dart';
import 'package:movie/models/movie_detail_model.dart';
import 'package:movie/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String title, backdropPath, overview, releaseDate;
  final int id;
  final double voteAverage;

  const DetailScreen({
    super.key,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.voteAverage,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedMovies = prefs.getStringList('likedMovies');
    if (likedMovies != null) {
      if (likedMovies.contains(widget.id.toString()) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedMovies', []);
    }
  }

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedMovies = prefs.getStringList('likedMovies');
    if (likedMovies != null) {
      if (isLiked) {
        likedMovies.remove(widget.id.toString());
      } else {
        likedMovies.add(widget.id.toString());
      }
      await prefs.setStringList('likedMovies', likedMovies);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
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
                      child: Image.network(
                          'https://image.tmdb.org/t/p/w500${widget.backdropPath}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: movie,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.voteAverage}',
                          //'${snapshot.data!.voteAverage} / ${snapshot.data!.overview} / ${snapshot.data!.releaseDate}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text('...');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
