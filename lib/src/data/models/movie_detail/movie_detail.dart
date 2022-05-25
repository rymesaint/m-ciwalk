import 'thumbnail.dart';

class MovieDetail {
  String? id;
  String? title;
  String? slug;
  String? body;
  dynamic summary;
  String? link;
  String? trailer;
  String? createdAt;
  String? updatedAt;
  Thumbnail? thumbnail;

  MovieDetail({
    this.id,
    this.title,
    this.slug,
    this.body,
    this.summary,
    this.link,
    this.trailer,
    this.createdAt,
    this.updatedAt,
    this.thumbnail,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) => MovieDetail(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        body: json['body'] as String?,
        summary: json['summary'] as dynamic,
        link: json['link'] as String?,
        trailer: json['trailer'] as String?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'body': body,
        'summary': summary,
        'link': link,
        'trailer': trailer,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'thumbnail': thumbnail?.toJson(),
      };
}
