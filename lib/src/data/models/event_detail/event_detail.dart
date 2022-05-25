import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'tag.dart';
import 'thumbnail.dart';

class EventDetail {
  String? id;
  String? title;
  String? slug;
  String? body;
  dynamic summary;
  String? started;
  String? ended;
  String? createdAt;
  String? updatedAt;
  String? type;
  List<dynamic>? gallery;
  Thumbnail? thumbnail;
  List<Tag>? tags;

  EventDetail({
    this.id,
    this.title,
    this.slug,
    this.body,
    this.summary,
    this.started,
    this.ended,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.gallery,
    this.thumbnail,
    this.tags,
  });

  factory EventDetail.fromJson(Map<String, dynamic> json) => EventDetail(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        body: json['body'] as String?,
        summary: json['summary'] as dynamic,
        started: json['started'] as String?,
        ended: json['ended'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        type: json['type'] as String?,
        gallery: json['gallery'] as List<dynamic>?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'body': body,
        'summary': summary,
        'started': started,
        'ended': ended,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'type': type,
        'gallery': gallery,
        'thumbnail': thumbnail?.toJson(),
        'tags': tags?.map((e) => e.toJson()).toList(),
      };

  String get startedFormat =>
      DateFormat('d MMMM yyyy').format(DateTime.tryParse(started.toString())!);

  String get endedFormat =>
      DateFormat('d MMMM yyyy').format(DateTime.tryParse(ended.toString())!);

  String? get statusEvent => ended == null
      ? 'Finished'
      : DateTime.now().isAfter(DateTime.tryParse(ended.toString())!) == true
          ? 'Finished'
          : '$startedFormat - $endedFormat';

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! EventDetail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      slug.hashCode ^
      body.hashCode ^
      summary.hashCode ^
      started.hashCode ^
      ended.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      type.hashCode ^
      gallery.hashCode ^
      thumbnail.hashCode ^
      tags.hashCode;
}
