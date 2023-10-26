import 'dart:ui';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//Models
import '../models/movie.dart';
import '../models/search_category.dart';
import '../widgets/movie_tile.dart';

class HomePage extends ConsumerWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late TextEditingController _searchTextFeildController;
  @override
  Widget build(BuildContext context, WidgetRef watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _searchTextFeildController = TextEditingController();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(),
            _foregroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
              'https://images.unsplash.com/photo-1509490927285-34bd4d057c88?auto=format&fit=crop&q=80&w=1374&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
      // width: _deviceWidth * 0.88,
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget().animate().fade(),
          Container(
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.01,
            ),
            child: _moviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
        height: _deviceHeight * 0.08,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _searchFieldWidget(),
            __categorySelectionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.5,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFeildController,
        onSubmitted: (_input) {},
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            contentPadding:
                EdgeInsets.symmetric(vertical: _deviceHeight * 0.008),
            hintText: 'Поиск....',
            hintStyle: TextStyle(color: Colors.white30),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
              size: 20,
            )),
      ),
    );
  }

  Widget __categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.grey,
      value: SearchCategory.popularKey,
      icon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (_value) {},
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.popularKey,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.nowPlaying,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.nowPlayingKey,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.upcomingKey,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = [];
    for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
        name: "Alina Жопка САМАЯ ВРЕДНАЯ",
        language: "RU",
        isAdult: false,
        description: 'Алина лучшая жопка из всех жопок в мире живущих',
        posterPath: '/iwsMu0ehRPbtaSxqiaUDQB9qMWT.jpg',
        backdropPath: '/rMvPXy8PUjj1o8o1pzgQbdNCsvj.jpg',
        rating: 6.7,
        realeaseDate: '26-07-1995',
        id: 1,
      ));
    }

    if (_movies.length != 0) {
      return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _movies.length,
          itemBuilder: (BuildContext _context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MovieTile(
                    height: _deviceHeight * 0.2,
                    width: _deviceWidth * 0.85,
                    movie: _movies[_count],
                  ).animate().flip(),
                ),
              ),
            );
          });
    } else {
      return Center(
        child: LoadingAnimationWidget.discreteCircle(
            color: Colors.black, size: _deviceHeight * 0.2),
      );
    }
  }
}
