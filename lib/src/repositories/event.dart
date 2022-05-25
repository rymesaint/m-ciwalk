import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/event_detail/event_detail.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/events/service.dart';

class EventRepository {
  final EventService _eventService = EventService();
  Future<Resource<List<Event>>> getEvents({
    int? start,
    int? limit,
    String? query,
    String? type,
    String? sortBy = 'createdAt:desc',
  }) async {
    return _eventService.getEvents(
      start: start,
      limit: limit,
      query: query,
      type: type,
      sortBy: sortBy,
    );
  }

  Future<Resource<EventDetail>> getEventDetails({
    String? id,
  }) async {
    return _eventService.getEventDetails(id: id);
  }
}
