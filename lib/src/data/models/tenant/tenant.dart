import 'package:ciwalk/src/data/models/gallery.dart';
import 'package:ciwalk/src/data/models/location/location.dart';
import 'package:ciwalk/src/data/models/thumbnail.dart';

import 'tag.dart';

class Tenant {
  String? id;
  String? name;
  String? slug;
  String? type;
  String? body;
  String? summary;
  String? opened;
  String? closed;
  String? contact;
  String? link;
  String? coordinate;
  Thumbnail? thumbnail;
  List<Gallery>? gallery;
  List<Location>? locations;
  List<Tag>? tags;

  Tenant({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.coordinate,
    this.tags,
    this.body,
    this.closed,
    this.contact,
    this.gallery,
    this.link,
    this.locations,
    this.opened,
    this.summary,
    this.thumbnail,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json['id'] as String?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        type: json['type'] as String?,
        coordinate: json['coordinate'] as String?,
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        body: json['body'] as String?,
        closed: json['closed'] as String?,
        contact: json['contact'] as String?,
        opened: json['opened'] as String?,
        summary: json['summary'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail']),
        link: json['link'] as String?,
        gallery: json['gallery'] == []
            ? []
            : (json['gallery'] as List<dynamic>?)
                ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
                .toList(),
        locations: (json['locations'] as List<dynamic>?)
            ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'type': type,
        'coordinate': coordinate,
        'tags': tags?.map((e) => e.toJson()).toList(),
        'body': body,
        'summary': summary,
        'opened': opened,
        'closed': closed,
        'contact': contact,
        'thumbnail': thumbnail?.toJson(),
        'link': link,
        'gallery': gallery?.map((e) => e.toJson()).toList(),
        'locations': locations?.map((e) => e.toJson()).toList(),
      };
}
