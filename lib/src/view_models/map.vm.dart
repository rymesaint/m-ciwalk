import 'package:ciwalk/src/data/models/location/location.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/repositories/map.dart';
import 'package:ciwalk/src/repositories/tenant.dart';
import 'package:ciwalk/src/view/tenant/tenant_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MapViewModel extends BaseViewModel {
  final locations = Resource<List<Location>>(
    data: [],
    error: null,
    metadata: null,
  ).obs;
  final selectedLocation = Location().obs;
  final tenants = Resource<List<Tenant>>(
    data: [],
    error: null,
    metadata: null,
  ).obs;
  final loadingTenant = false.obs;

  @override
  void onInit() {
    _fetchLocations();
    super.onInit();
  }

  _fetchLocations() async {
    EasyLoading.show();
    var response = await MapRepository().getLocations();
    locations(response);
    EasyLoading.dismiss();
  }

  selectLocation(Location? location) async {
    EasyLoading.show();
    var response = await MapRepository().getLocation(id: location!.id);
    _getTenants(location);
    selectedLocation(response.data);
    EasyLoading.dismiss();
  }

  _getTenants(Location? location) async {
    loadingTenant(true);
    var response =
        await TenantRepository().getTenants(locationId: location!.id);
    tenants(response);
    loadingTenant(false);
  }

  openTenant(Tenant? tenant) {
    Get.toNamed(TenantDetailScreen.routeName, arguments: tenant);
  }
}
