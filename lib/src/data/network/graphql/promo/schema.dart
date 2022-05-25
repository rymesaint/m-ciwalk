String getPromosQuery = """
query getPromos(\$limit: Int = 10, \$start: Int = null, \$sortBy: String = "createdAt:desc", \$query: String = null){
    promotionsConnection (
      where: {
        title_contains: \$query, 
        tags: {slug_contains: null}, 
        _id_ne: null, 
        type: null, 
        tenant: {slug_contains: null}}, 
        sort: \$sortBy, 
        limit: \$limit, 
        start: \$start
    ) {
        values {
            id
            title
            type
            summary
            started
            ended
            slug
            thumbnail {
                public_id
                name
                provider
                url
            }
            tenant {
                name
                slug
                id
            }
        }
        aggregate {
            count
            totalCount
        }
    }
}
""";

String getPromoDetailsQuery = """
query getPromoDetails(\$id: ID!){
        promotion(id: \$id) {
          _id,
          title,
          slug,
          body,
          summary,
          started,
          ended,
          type,
          createdAt,
          updatedAt,
          thumbnail {
            name,
            public_id,
            provider,
            url
          },
          tags {
            name,
            slug
          },
          tenant {
            id,
            name,
            slug,
            type
          }
        }
      }
""";
