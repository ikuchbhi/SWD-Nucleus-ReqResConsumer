import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/constants.dart';
import '../models/req_res_resource.dart';

/// An interface for [ReqResResourceProvider]
///
/// Must be able to fetch [ReqResResource]s

abstract class ReqResResourceProvider {
  Stream<List<ReqResResource>> getResources(int pageIndex);
}

class ReqResResourceProviderImpl implements ReqResResourceProvider {
  int total = 0, perPage = 0;
  @override
  Stream<List<ReqResResource>> getResources(int pageIndex) async* {
    final url = Uri.parse("$API_URL/unknown/$pageIndex");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final parsedRes = jsonDecode(res.body) as Map<String, Object>;
      total = parsedRes[API_RESOURCES_TOTAL] as int;
      perPage = parsedRes[API_RESOURCES_PER_PAGE] as int;
      final resources =
          parsedRes[API_RESOURCES_DATA] as List<Map<String, Object>>;
      yield resources.map((resource) {
        return ReqResResource(
          id: resource[API_RESOURCE_ID] as int,
          name: resource[API_RESOURCE_NAME] as String,
          color: resource[API_RESOURCE_COLOR] as String,
          year: resource[API_RESOURCE_YEAR] as int,
          pantoneValue: resource[API_RESOURCE_ID] as String,
        );
      }).toList();
    } else {
      yield [];
    }
  }
}
