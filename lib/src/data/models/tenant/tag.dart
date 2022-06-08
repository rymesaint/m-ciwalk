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
}
