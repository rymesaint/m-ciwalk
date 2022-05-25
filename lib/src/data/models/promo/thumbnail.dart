import 'package:collection/collection.dart';

class Thumbnail {
  String? publicId;
  String? name;
  String? provider;
  String? url;

  Thumbnail({this.publicId, this.name, this.provider, this.url});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        publicId: json['public_id'] as String?,
        name: json['name'] as String?,
        provider: json['provider'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'public_id': publicId,
        'name': name,
        'provider': provider,
        'url': url,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Thumbnail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      publicId.hashCode ^ name.hashCode ^ provider.hashCode ^ url.hashCode;
}
