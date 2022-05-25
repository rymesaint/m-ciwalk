import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'thumbnail.dart';

class Event {
  String? type;
  String? id;
  String? title;
  dynamic summary;
  String? started;
  String? ended;
  String? slug;
  Thumbnail? thumbnail;

  Event({
    this.type,
    this.id,
    this.title,
    this.summary,
    this.started,
    this.ended,
    this.slug,
    this.thumbnail,
  });

  factory Event.fromMap(Map<String, dynamic> data) => Event(
        type: data['type'] as String?,
        id: data['id'] as String?,
        title: data['title'] as String?,
        summary: data['summary'] as dynamic,
        started: data['started'] as String?,
        ended: data['ended'] as String?,
        slug: data['slug'] as String?,
        thumbnail: data['thumbnail'] == null
            ? null
            : Thumbnail.fromMap(data['thumbnail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'id': id,
        'title': title,
        'summary': summary,
        'started': started,
        'ended': ended,
        'slug': slug,
        'thumbnail': thumbnail?.toMap(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Event) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

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
  int get hashCode =>
      type.hashCode ^
      id.hashCode ^
      title.hashCode ^
      summary.hashCode ^
      started.hashCode ^
      ended.hashCode ^
      slug.hashCode ^
      thumbnail.hashCode;
}
