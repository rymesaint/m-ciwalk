import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/event.dart';
import 'package:ciwalk/src/view/events/event_detail_screen.dart';
import 'package:ciwalk/src/view/homepage/component/event.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EventSearchDelegate extends SearchDelegate<Event> {
  final EventRepository eventRepository = EventRepository();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Resource<List<Event>>>(
        future: eventRepository.getEvents(limit: 5, query: query.toLowerCase()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive().centered();
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
            ),
            itemCount: snapshot.data?.data!.length,
            itemBuilder: (context, index) {
              final event = snapshot.data!.data![index];
              return EventCard(
                event: event,
                onTap: () => openDetail(event),
              );
            },
          );
        });
  }

  openDetail(Event event) async {
    Get.toNamed(EventDetailScreen.routeName, arguments: event);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<Resource<List<Event>>>(
        future: eventRepository.getEvents(limit: 5, query: query.toLowerCase()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive().centered();
          }
          var events = snapshot.data?.data?.where((event) =>
              event.title!.toLowerCase().contains(query.toLowerCase()));
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 250,
            ),
            children: events!
                .map((event) => EventCard(
                      event: event,
                      onTap: () => openDetail(event),
                    ))
                .toList(),
          );
        });
  }
}
