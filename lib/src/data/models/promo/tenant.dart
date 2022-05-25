import 'package:collection/collection.dart';

class Tenant {
  String? name;
  String? slug;
  String? id;

  Tenant({this.name, this.slug, this.id});

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'id': id,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Tenant) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ slug.hashCode ^ id.hashCode;
}
