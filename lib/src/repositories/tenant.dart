import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/data/network/graphql/tenants/service.dart';

class TenantRepository {
  final TenantService _tenantService = TenantService();
  Future<Resource<List<Tenant>>> getTenants({String? locationId}) async {
    return _tenantService.getTenants(locationId: locationId);
  }

  Future<Resource<Tenant>> getTenantDetail({String? id}) async {
    return _tenantService.getTenantDetail(id: id);
  }

  Future<Resource<List<Tenant>>> getRelatedTenants({String? currentTenantId, String? type}) async {
    return _tenantService.getRelatedTenants(currentTenantId: currentTenantId, type: type);
  }
}
