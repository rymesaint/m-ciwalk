import 'package:ciwalk/src/consts/config.dart';

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

  String? get imageUrl {
    if (provider == 'local') {
      return '${Config.baseImage}$url';
    } else {
      return url;
    }
  }
}
