class Gallery {
  String? publicId;
  String? id;
  String? provider;
  String? url;

  Gallery({this.publicId, this.id, this.provider, this.url});

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        publicId: json['public_id'] as String?,
        id: json['_id'] as String?,
        provider: json['provider'] as String?,
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'public_id': publicId,
        '_id': id,
        'provider': provider,
        'url': url,
      };
}
