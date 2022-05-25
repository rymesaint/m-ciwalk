import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/data/models/movie_detail/movie_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/misc/browser.dart';
import 'package:ciwalk/src/repositories/movie.dart';
import 'package:ciwalk/src/view/movies/movie_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MovieDetailViewModel extends BaseViewModel {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  final isLoading = false.obs;
  final loadingRelatedMovies = false.obs;
  final result = Resource<MovieDetail>(
    data: MovieDetail(),
  ).obs;
  final movieResults = Resource<List<Movie>>(data: []).obs;

  MovieDetailViewModel() {
    result.value.data?.id = Get.arguments.id;
  }

  @override
  void onInit() {
    fetchMovie();
    _fetchMovies();
    super.onInit();
  }

  fetchMovie() async {
    isLoading(true);
    var response = await MovieRepository().getEventDetails(
      id: result.value.data?.id,
    );
    isLoading(false);

    result.value.data = response.data;
  }

  _fetchMovies() async {
    loadingRelatedMovies(true);
    var response = await MovieRepository().getMovies(start: 0, limit: 6);
    loadingRelatedMovies(false);
    movieResults.value.data = response.data;
  }

  openMovieDetail(Movie movie) {
    Get.back();
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.toNamed(MovieDetailScreen.routeName, arguments: movie);
    });
  }

  openSchedule() async {
    await _firebaseAnalytics.logEvent(name: 'opening_schedule');
    ChromeSafariBrowser browser = MyBrowser();
    await browser.open(url: Uri.tryParse(result.value.data!.link.toString())!);
  }

  openTrailer() async {
    await _firebaseAnalytics.logEvent(name: 'opening_trailer');
    ChromeSafariBrowser browser = MyBrowser();
    await browser.open(
        url: Uri.tryParse(result.value.data!.trailer.toString())!);
  }
}
