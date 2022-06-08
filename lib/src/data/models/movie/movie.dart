import 'package:ciwalk/src/data/models/thumbnail.dart';

class Movie {
  String? id;
  String? title;
  dynamic summary;
  dynamic duration;
  String? link;
  String? slug;
  Thumbnail? thumbnail;

  Movie({
    this.id,
    this.title,
    this.summary,
    this.duration,
    this.link,
    this.slug,
    this.thumbnail,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as String?,
        title: json['title'] as String?,
        summary: json['summary'] as dynamic,
        duration: json['duration'] as dynamic,
        link: json['link'] as String?,
        slug: json['slug'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'summary': summary,
        'duration': duration,
        'link': link,
        'slug': slug,
        'thumbnail': thumbnail?.toJson(),
      };
}
