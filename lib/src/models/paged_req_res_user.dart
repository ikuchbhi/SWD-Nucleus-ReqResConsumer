import 'req_res_user.dart';

class PagedReqResUser {
  final int page;
  final List<ReqResUser> users;

  PagedReqResUser(this.page, this.users);

  PagedReqResUser.err()
      : page = -1,
        users = [];
}
