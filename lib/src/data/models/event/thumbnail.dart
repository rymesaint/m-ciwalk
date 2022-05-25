import 'dart:convert';

import 'package:collection/collection.dart';

class Thumbnail {
  String? publicId;
  String? name;
  String? provider;
  String? url;

  Thumbnail({this.publicId, this.name, this.provider, this.url});

  factory Thumbnail.fromMap(Map<String, dynamic> data) => Thumbnail(
        publicId: data['public_id'] as String?,
        name: data['name'] as String?,
        provider: data['provider'] as String?,
        url: data['url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'public_id': publicId,
        'name': name,
        'provider': provider,
        'url': url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Thumbnail].
  factory Thumbnail.fromJson(String data) {
    return Thumbnail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Thumbnail] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Thumbnail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      publicId.hashCode ^ name.hashCode ^ provider.hashCode ^ url.hashCode;
}
