//models
import 'movie.dart';
import 'search_category.dart';

class MainScreenData {
  final List<Movie> movies;
  final int page;
  final String searchCategory;
  final String searchText;

  MainScreenData({
    required this.movies,
    required this.page,
    required this.searchCategory,
    required this.searchText,
  });

  MainScreenData.inital()
      : movies = [],
        page = 1,
        searchCategory = SearchCategory.popular,
        searchText = '';

  MainScreenData? copyWith(
    List<Movie>? movies,
    int? page,
    String? category,
    String? searchText,
  ) {
    return MainScreenData(
        movies: movies ?? this.movies,
        page: page ?? this.page,
        searchCategory: category ?? this.searchCategory,
        searchText: searchText ?? this.searchText);
  }
}
