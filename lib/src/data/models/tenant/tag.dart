class Tag {
  String? id;
  String? name;
  String? slug;
  String? type;

  Tag({this.id, this.name, this.slug, this.type});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'type': type,
      };
}
