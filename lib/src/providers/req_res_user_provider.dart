import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reqres_consumer/src/common/constants.dart';

import '../models/req_res_user.dart';

/// An interface for [ReqResUserProvider]
///
/// Must be able to fetch [ReqResUser]s

abstract class ReqResUserProvider {
  Future<List<ReqResUser>> getUsers();
}

/// Implementation of [ReqResUserProvider]
class ReqResUserProviderImpl implements ReqResUserProvider {
  int total = 0, perPage = 0, _pageIndex = 0;
  @override
  Future<List<ReqResUser>> getUsers() async {
    final url = Uri.parse("$API_URL/users?page=$_pageIndex");
    final res = await http.get(url);
    if (res.statusCode == 200) {
      _pageIndex++;
      final parsedRes = Map<String, Object>.from(jsonDecode(res.body));
      final data = parsedRes[API_USERS_DATA];
      total = parsedRes[API_USERS_TOTAL] as int;
      perPage = parsedRes[API_USERS_PER_PAGE] as int;
      final users = List<Map>.from(data as List<dynamic>);
      return users.map((user) {
        return ReqResUser(
          id: user[API_USER_ID] as int,
          firstName: user[API_USER_FIRSTNAME] as String,
          lastName: user[API_USER_LASTNAME] as String,
          email: user[API_USER_EMAIL] as String,
          avatarUrl: user[API_USER_AVATAR] as String,
        );
      }).toList();
    } else {
      return [];
    }
  }
}
