String getMoviesQuery = """
query getMovies(\$sortBy: String = "createdAt:desc", \$limit: Int) {
    moviesConnection (
      sort: \$sortBy, 
      limit: \$limit, 
      where: {_id_ne: null}
    ) {
        values {
            id
            age
            title
            summary
            casts
            released
            duration
            country
            director
            writer
            link
            tags {
                name
                slug
            }
            slug
            trailer
            thumbnail {
                public_id
                name
                provider
                url
            }
        }
        aggregate {
            count
            totalCount
        }
    }
}
""";

String getMovieDetailsQuery = """
query getMovieDetails(\$id: ID!) {
        movie(id: \$id) {
          _id,
          title,
          slug,
          body,
          summary,
          link,
          trailer,
          createdAt,
          updatedAt,
          thumbnail {
            name,
            public_id,
            provider,
            url
          }
        }
      }
""";
