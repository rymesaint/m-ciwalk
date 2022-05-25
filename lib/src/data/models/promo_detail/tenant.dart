class Tenant {
  String? id;
  String? name;
  String? slug;
  String? type;

  Tenant({this.id, this.name, this.slug, this.type});

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json['id'] as String?,
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'type': type,
      };
}
