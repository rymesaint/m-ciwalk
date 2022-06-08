String getLocationsQuery = """
query {
    locations {
        id
        name
    }
}
""";

String getLocationQuery = """
query getLocation(\$id: ID!) {
  location(id: \$id) {
    _id,
    name,
    map {
      url
    }
  }
}
""";
