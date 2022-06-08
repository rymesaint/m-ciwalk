class MapLocation {
  String? url;

  MapLocation({this.url});

  factory MapLocation.fromJson(Map<String, dynamic> json) => MapLocation(
        url: json['url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'url': url,
      };
}
