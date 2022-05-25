import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'tenant.dart';
import 'thumbnail.dart';

class Promo {
  String? id;
  String? title;
  String? type;
  dynamic summary;
  String? started;
  String? ended;
  String? slug;
  Thumbnail? thumbnail;
  Tenant? tenant;

  Promo({
    this.id,
    this.title,
    this.type,
    this.summary,
    this.started,
    this.ended,
    this.slug,
    this.thumbnail,
    this.tenant,
  });

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json['id'] as String?,
        title: json['title'] as String?,
        type: json['type'] as String?,
        summary: json['summary'] as dynamic,
        started: json['started'] as String?,
        ended: json['ended'] as String?,
        slug: json['slug'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
        tenant: json['tenant'] == null
            ? null
            : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type,
        'summary': summary,
        'started': started,
        'ended': ended,
        'slug': slug,
        'thumbnail': thumbnail?.toJson(),
        'tenant': tenant?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Promo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  String get startedFormat =>
      DateFormat('d MMMM yyyy').format(DateTime.tryParse(started.toString())!);

  String get endedFormat =>
      DateFormat('d MMMM yyyy').format(DateTime.tryParse(ended.toString())!);

  String? get statusPromo => ended == null
      ? 'Finished'
      : DateTime.now().isAfter(DateTime.tryParse(ended.toString())!) == true
          ? 'Finished'
          : '$startedFormat - $endedFormat';

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      type.hashCode ^
      summary.hashCode ^
      started.hashCode ^
      ended.hashCode ^
      slug.hashCode ^
      thumbnail.hashCode ^
      tenant.hashCode;
}
