import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/req_res_user_provider.dart';

import '../models/req_res_user.dart';

class ReqResUsers extends StateNotifier<List<ReqResUser>> {
  final ReqResUserProvider provider;
  int pageIndex = 0;

  final List<ReqResUser> users;

  ReqResUsers(this.provider)
      : users = [],
        super([]);

  void getUsers() async {
    final list = await provider.getUsers();
    if (list.isNotEmpty) {
      users.addAll(list);
      state = list;
    }
    state = [];
  }
}
