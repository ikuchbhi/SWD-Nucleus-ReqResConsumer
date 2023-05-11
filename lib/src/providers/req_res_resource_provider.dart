import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reqres_consumer/src/models/api_exception.dart';

import '../common/constants.dart';
import '../models/req_res_resource.dart';

/// An interface for [ReqResResourceProvider]
///
/// Must be able to fetch [ReqResResource]s

abstract class ReqResResourceProvider {
  Future<ReqResResource?> getResource(int resourceNumber);
}

class ReqResResourceProviderImpl implements ReqResResourceProvider {
  @override
  Future<ReqResResource?> getResource(int resourceNumber) async {
    try {
      final url = Uri.parse("$API_URL/unknown/$resourceNumber");
      final res = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        final parsedRes = Map<String, Object>.from(jsonDecode(res.body));
        final data = parsedRes[API_RESOURCES_DATA];
        final resource = Map<String, Object>.from(data as Map);
        return ReqResResource(
          id: resource[API_RESOURCE_ID] as int,
          name: resource[API_RESOURCE_NAME] as String,
          color: resource[API_RESOURCE_COLOR] as String,
          year: resource[API_RESOURCE_YEAR] as int,
          pantoneValue: resource[API_RESOURCE_PANTONE_VALUE] as String,
        );
      }
      return null;
    } catch (e) {
      throw APIException(e.toString());
    }
  }
}
