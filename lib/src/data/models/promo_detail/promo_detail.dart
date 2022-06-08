import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/data/models/thumbnail.dart';
import 'package:intl/intl.dart';

import 'tag.dart';

class PromoDetail {
  String? id;
  String? title;
  String? slug;
  String? body;
  dynamic summary;
  String? started;
  String? ended;
  String? type;
  String? createdAt;
  String? updatedAt;
  Thumbnail? thumbnail;
  List<Tag>? tags;
  Tenant? tenant;

  PromoDetail({
    this.id,
    this.title,
    this.slug,
    this.body,
    this.summary,
    this.started,
    this.ended,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.thumbnail,
    this.tags,
    this.tenant,
  });

  factory PromoDetail.fromJson(Map<String, dynamic> json) => PromoDetail(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        body: json['body'] as String?,
        summary: json['summary'] as dynamic,
        started: json['started'] as String?,
        ended: json['ended'] as String?,
        type: json['type'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        tenant: json['tenant'] == null
            ? null
            : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'body': body,
        'summary': summary,
        'started': started,
        'ended': ended,
        'type': type,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'thumbnail': thumbnail?.toJson(),
        'tags': tags?.map((e) => e.toJson()).toList(),
        'tenant': tenant?.toJson(),
      };

  String get startedFormat => started == null
      ? ''
      : DateFormat('d MMMM yyyy')
          .format(DateTime.tryParse(started.toString())!);

  String get endedFormat => ended == null
      ? ''
      : DateFormat('d MMMM yyyy').format(DateTime.tryParse(ended.toString())!);

  String? get statusPromo => ended == null
      ? 'Finished'
      : DateTime.now().isAfter(DateTime.tryParse(ended.toString())!) == true
          ? 'Finished'
          : '$startedFormat - $endedFormat';
}
