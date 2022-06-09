String getTagsQuery = """
query getTags(\$where: JSON = null)
{
    tags (where: \$where) {
        id
        name
        slug
        type
    }
}
""";

String getTenantByTagQuery = """
query getTenantByTag(\$where: JSON = null, \$limit: Int = 16){
    tenantsConnection (
      where: {
        name_contains: null, 
        locations: {
          name_contains: null
        }, tags: {
          slug_contains: ["Accessories-gadget-handphone-fashion"]
        }, 
        _id_ne: null, 
        type_contains: "shopping"
      }, 
      sort: "createdAt:desc", 
      limit: 16, 
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
