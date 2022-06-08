import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/misc/browser.dart';
import 'package:ciwalk/src/repositories/tenant.dart';
import 'package:ciwalk/src/view/tenant/component/tenant_locations.bottomsheet.dart';
import 'package:ciwalk/src/view/tenant/tenant_detail_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TenantViewModel extends BaseViewModel {
  final tenant = Tenant(
    gallery: [],
    locations: [],
  ).obs;

  final relatedTenants = Resource<List<Tenant>>(
    data: [],
  ).obs;
  final tenantType = ''.obs;

  TenantViewModel() {
    tenant(Get.arguments);
    tenantType(Get.arguments?.type);
  }

  @override
  void onInit() {
    _fetchRelatedTenants();
    _fetchTenant();
    super.onInit();
  }

  _fetchRelatedTenants() async {
    var response = await TenantRepository().getRelatedTenants(
        currentTenantId: tenant.value.id, type: tenantType.value);
    relatedTenants(response);
  }

  _fetchTenant() async {
    EasyLoading.show();
    var response =
        await TenantRepository().getTenantDetail(id: tenant.value.id);
    tenant(response.data);
    EasyLoading.dismiss();
  }

  openTenantLocations() {
    Get.bottomSheet(
      TenantLocationsBottomsheet(vm: this),
      isScrollControlled: true,
    );
  }

  openLink() async {
    ChromeSafariBrowser browser = MyBrowser();
    await browser.open(url: Uri.tryParse(tenant.value.link!)!);
  }

  openTenant(Tenant? tenant) {
    Get.back();
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.toNamed(TenantDetailScreen.routeName, arguments: tenant);
    });
  }
}
