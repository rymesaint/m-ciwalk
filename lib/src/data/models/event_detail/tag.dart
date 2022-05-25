import 'package:collection/collection.dart';

class Tag {
  String? name;
  String? slug;

  Tag({this.name, this.slug});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Tag) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ slug.hashCode;
}
