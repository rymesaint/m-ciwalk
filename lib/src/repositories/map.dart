import 'package:ciwalk/src/data/models/location/location.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/network/graphql/maps/service.dart';

class MapRepository {
  final MapService _mapService = MapService();
  Future<Resource<List<Location>>> getLocations() async {
    return _mapService.getLocations();
  }

  Future<Resource<Location>> getLocation({String? id}) async {
    return _mapService.getLocation(id: id);
  }
}
