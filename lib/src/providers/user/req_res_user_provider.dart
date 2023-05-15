import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reqres_consumer/src/common/constants.dart';
import 'package:reqres_consumer/src/models/api_exception.dart';
import 'package:reqres_consumer/src/models/paged_req_res_user.dart';

import '../../models/req_res_user.dart';

/// An interface for [ReqResUserProvider]
///
/// Must be able to fetch [ReqResUser]s

abstract class ReqResUserProvider {
  int total = 0;
  Future<PagedReqResUser> getUsers(int pageIndex);
}

/// Implementation of [ReqResUserProvider]
class ReqResUserProviderImpl implements ReqResUserProvider {
  @override
  int total = 0;
  // List<ReqResUser> usersList = [];

  @override
  Future<PagedReqResUser> getUsers(int pageIndex) async {
    try {
      final url = Uri.parse("$API_URL/users?page=$pageIndex");
      final res = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (res.statusCode == 200) {
        final parsedRes = Map<String, Object>.from(jsonDecode(res.body));
        final data = parsedRes[API_USERS_DATA];
        final page = parsedRes[API_USERS_PAGE] as int;
        total = parsedRes[API_USERS_TOTAL] as int;
        final usersMap = List<Map>.from(data as List<dynamic>);
        final users = usersMap.map((user) {
          return ReqResUser(
            id: user[API_USER_ID] as int,
            firstName: user[API_USER_FIRSTNAME] as String,
            lastName: user[API_USER_LASTNAME] as String,
            email: user[API_USER_EMAIL] as String,
            avatarUrl: user[API_USER_AVATAR] as String,
          );
        }).toList();
        return PagedReqResUser(page, users);
      } else {
        return PagedReqResUser.err();
      }
    } catch (e) {
      throw APIException(e.toString());
    }
  }
}
