String getTenantsQuery = """
query getTenants(\$where: JSON = null, \$start: Int = null, \$limit: Int = 16) {
    tenantsConnection (
      where: \$where,
      limit: \$limit,
      start: \$start,
      sort: "createdAt:desc"
    ) 
      {
        values {
            id
            name
            slug
            type
            coordinate
            tags {
                name
                slug
            }
            thumbnail {
              name,
              public_id,
              provider,
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

String getTenantDetailQuery = """
query getTenantDetail(\$id: ID!) {
    tenant(id: \$id) {
      _id,
      id,
      name,
      slug,
      body,
      summary,
      createdAt,
      updatedAt,
      opened,
      closed,
      contact,
      link,
      thumbnail {
        name,
        public_id,
        provider,
        url
      },
      gallery {
        public_id,
        _id,
        provider,
        url
      }
      locations {
        name
      },
      tags {
        name,
        slug
      }
    }
  }
""";

String relatedTenantsQuery = """
query getRelatedTenants(\$where: JSON = null){
    tenantsConnection (
      where: \$where, 
      sort: "createdAt:desc", 
      limit: 4, 
      start: null
    ) {
        values {
            id
            name
            summary
            slug
            tags {
                name
                slug
            }
            locations {
                name
            }
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
