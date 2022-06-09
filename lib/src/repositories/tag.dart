import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tag.dart';
import 'package:ciwalk/src/data/models/tenant/tenant.dart';
import 'package:ciwalk/src/data/network/graphql/tags/service.dart';

class TagRepository {
  final TagService _tagService = TagService();
  Future<Resource<List<Tag>>> getTags() async {
    return _tagService.getTags();
  }

  Future<Resource<List<Tenant>>> getTenants(
      {String? slug, String? type, int? page}) async {
    return _tagService.getTenants(slug: slug, type: type, page: page);
  }
}
