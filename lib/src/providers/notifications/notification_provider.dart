import '../../models/req_res_user.dart';

abstract class NotificationProvider {
  Future<void> init();

  Future<void> showNotification(ReqResUser user);
}

class NotificationProviderImpl implements NotificationProvider {
  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> showNotification(ReqResUser user) {
    // TODO: implement showNotification
    throw UnimplementedError();
  }
}
