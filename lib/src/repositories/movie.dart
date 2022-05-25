import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/data/models/movie_detail/movie_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/movies/service.dart';

class MovieRepository {
  final MovieService _movieService = MovieService();
  Future<Resource<List<Movie>>> getMovies({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy = 'createdAt:desc',
  }) async {
    return _movieService.getMovies(
      start: start,
      limit: limit,
      query: query,
      type: type,
      sortBy: sortBy,
    );
  }

  Future<Resource<MovieDetail>> getEventDetails({
    String? id,
  }) async {
    return _movieService.getMovieDetails(id: id);
  }
}
