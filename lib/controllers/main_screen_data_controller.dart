// Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

// Models
import '../models/main_screen_data.dart';
import '../models/movie.dart';

// Service
import '../services/movie_service.dart';

class MainScreenDataController extends StateNotifier<MainScreenData> {
  MainScreenDataController([MainScreenData? state])
      : super(state ?? MainScreenData.inital()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> _movies = [];
      _movies = await _movieService.getPopularMovies(page: state.page);
    } catch (e) {}
  }
}
