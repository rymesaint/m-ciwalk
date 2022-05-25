import 'package:collection/collection.dart';

class Thumbnail {
  String? name;
  String? publicId;
  String? provider;
  String? url;

  Thumbnail({this.name, this.publicId, this.provider, this.url});

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json['name'] as String?,
        publicId: json['public_id'] as String?,
        provider: json['provider'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'public_id': publicId,
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
      name.hashCode ^ publicId.hashCode ^ provider.hashCode ^ url.hashCode;
}
