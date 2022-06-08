String getEventsQuery = """
query getEvents(\$limit: Int, \$start: Int = 0, \$where: JSON = null, \$sortBy: String = "createdAt:desc"){
    eventsConnection (
        where: \$where, 
        sort: \$sortBy, 
        limit: \$limit, 
        start: \$start
    ) {
        values {
            type
            id
            title
            summary
            started
            ended
            slug
            thumbnail 
            {
                public_id
                name
                provider
                url
            }
        }
        aggregate 
        {
            count
            totalCount
        }
    }
}
""";

String getEventDetailsQuery = """
query eventDetail(\$id: ID!){
        event(id: \$id) {
          _id,
          title,
          slug,
          body,
          summary,
          started,
          ended,
          createdAt,
          updatedAt,
          type,
          gallery {
            name,
            public_id,
            provider
          },
          thumbnail {
            name,
            public_id,
            provider,
            url
          },
          tags {
            name,
            slug
          }
        }
      }
""";
