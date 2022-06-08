import 'package:ciwalk/src/data/models/location/map_location.dart';

class Location {
  String? id;
  String? name;
  MapLocation? map;

  Location({this.id, this.name, this.map});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json['id'] as String?,
        name: json['name'] as String?,
        map: json['map'] == null ? null : MapLocation.fromJson(json['map']),
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'map': map?.toJson()};
}
