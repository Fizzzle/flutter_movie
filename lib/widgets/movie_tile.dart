// Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// models
import '../models/movie.dart';

class MovieTile extends StatelessWidget {
  MovieTile(
      {super.key,
      required this.height,
      required this.width,
      required this.movie});

  final GetIt _getIt = GetIt.instance;
  final double height;
  final double width;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie.posterURL()),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(_imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, height * 0.02, width * 0.02, 0),
      height: height,
      width: width * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.52,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  shadows: [
                    BoxShadow(
                      color: movie.rating > 7
                          ? Colors.green.shade900.withOpacity(0.7)
                          : Colors.red.shade900.withOpacity(
                              0.5), // Цвет тени (черный) с определенной прозрачностью
                      spreadRadius: 2, // Распространение тени по всему тексту
                      blurRadius: 5, // Радиус размытия тени
                      offset: Offset(0,
                          2), // Смещение тени относительно текста (горизонтальное, вертикальное)
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${movie.language.toUpperCase()}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${movie.realeaseDate}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              movie.description,
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
