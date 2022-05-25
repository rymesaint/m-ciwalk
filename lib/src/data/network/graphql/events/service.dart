import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/event_detail/event_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/client.dart';
import 'package:ciwalk/src/data/network/graphql/events/schema.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EventService {
  Future<Resource<List<Event>>> getEvents({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy,
  }) async {
    List<Event> events = [];

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getEventsQuery),
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
        data: events,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      events = result.data!["eventsConnection"]["values"]
          .map<Event>((dynamic item) => Event.fromMap(item))
          .toList();

      return Resource(
        data: events,
        error: null,
        metadata: Metadata(
          count: result.data!["eventsConnection"]["aggregate"]["count"],
          totalCount: result.data!["eventsConnection"]["aggregate"]
              ["totalCount"],
        ),
      );
    }
    return Resource(data: events, error: null, metadata: null);
  }

  Future<Resource<EventDetail>> getEventDetails({String? id}) async {
    EventDetail eventDetail = EventDetail();

    GraphQLConfig graphQLConfiguration = GraphQLConfig();
    GraphQLClient _client = graphQLConfiguration.getClient();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getEventDetailsQuery),
        variables: {
          "id": id,
        },
      ),
    );

    if (result.hasException) {
      return Resource(
        data: eventDetail,
        metadata: null,
        error: Error(
          extensions: result.exception?.graphqlErrors[0].extensions,
          message: result.exception?.graphqlErrors[0].message,
        ),
      );
    } else if (result.data != null && !result.isLoading) {
      eventDetail = EventDetail.fromJson(result.data!["event"]);

      return Resource(
        data: eventDetail,
        error: null,
        metadata: null,
      );
    }
    return Resource(data: eventDetail, error: null, metadata: null);
  }
}
