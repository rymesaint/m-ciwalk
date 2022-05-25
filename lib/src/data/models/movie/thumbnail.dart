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
}
