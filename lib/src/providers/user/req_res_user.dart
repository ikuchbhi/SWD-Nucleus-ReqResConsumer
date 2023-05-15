import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_consumer/src/models/paged_req_res_user.dart';

import 'req_res_user_provider.dart';

class ReqResUserNotifier extends StateNotifier<PagedReqResUser> {
  final ReqResUserProvider provider;

  ReqResUserNotifier(this.provider, {int index = 0})
      : super(
          PagedReqResUser(-1, []),
        );
}

final _reqresusersprovider = Provider((_) => ReqResUserProviderImpl());

final userProvider = StateNotifierProvider<ReqResUserNotifier, PagedReqResUser>(
  (ref) => ReqResUserNotifier(
    ref.read(_reqresusersprovider),
  ),
);
