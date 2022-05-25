import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/data/models/movie_detail/movie_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/movies/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MovieService {
  Future<Resource<List<Movie>>> getMovies({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy,
  }) async {
    List<Movie> movies = [];

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getMoviesQuery),
        variables: {
          "limit": limit,
          "start": start,
          "type": type,
          "query": query,
          "sortBy": sortBy,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: movies,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      movies = result.data!["moviesConnection"]["values"]
          .map<Movie>((dynamic item) => Movie.fromJson(item))
          .toList();

      return Resource(
        data: movies,
        error: null,
        metadata: Metadata(
          count: result.data!["moviesConnection"]["aggregate"]["count"],
          totalCount: result.data!["moviesConnection"]["aggregate"]
              ["totalCount"],
        ),
      );
    }
    return Resource(data: movies, error: null, metadata: null);
  }

  Future<Resource<MovieDetail>> getMovieDetails({String? id}) async {
    MovieDetail movieDetail = MovieDetail();

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getMovieDetailsQuery),
        variables: {
          "id": id,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: movieDetail,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      movieDetail = MovieDetail.fromJson(result.data!["movie"]);

      return Resource(
        data: movieDetail,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: movieDetail, error: null, metadata: null);
  }
}
