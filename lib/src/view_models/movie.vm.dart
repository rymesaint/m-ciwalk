import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/movie.dart';
import 'package:ciwalk/src/view/movies/component/movie_filter.dart';
import 'package:ciwalk/src/view/movies/movie_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieViewModel extends BaseViewModel {
  final isLoading = false.obs;
  final int limit = 12;
  final start = 0.obs;
  final sortBy = 'desc'.obs;
  final type = ''.obs;
  final result = Resource<List<Movie>>(
    data: [],
    error: null,
    metadata: null,
  ).obs;

  @override
  void onInit() {
    fetchMovies(page: 0);
    super.onInit();
  }

  fetchMovies({int? page}) async {
    isLoading(true);
    var response = await MovieRepository().getMovies(
      start: page,
      limit: limit,
      sortBy: 'createdAt:${sortBy.value}',
      type: type.value == '' ? null : type.value,
    );
    isLoading(false);
    result.value.error = response.error;
    result.value.metadata = response.metadata;
    result.value.data?.addAll(response.data!.map((e) => e));
  }

  void loadNextPage() {
    start.value += 12;
    fetchMovies(page: start.value);
  }

  openFilter() {
    Get.bottomSheet(MovieFilter(vm: this),
        isScrollControlled: true, isDismissible: true);
  }

  changeSortBy(String? sort) {
    if (sort != null) {
      start.value = 0;
      sortBy.value = sort;
      result.value.data?.clear();
      fetchMovies(page: start.value);
    }
  }

  changeType(String? typeSelected) {
    if (typeSelected != null) {
      start.value = 0;
      type.value = typeSelected;
      result.value.data?.clear();
      fetchMovies(page: start.value);
    }
  }

  openSearch(BuildContext context) {
    //   showSearch(context: context, delegate: EventSearchDelegate());
  }

  openDetail(Movie movie) async {
    Get.toNamed(MovieDetailScreen.routeName, arguments: movie);
  }
}
