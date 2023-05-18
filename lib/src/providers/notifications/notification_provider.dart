import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart' show Colors, GlobalKey, NavigatorState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/constants.dart';
import '../../models/req_res_user.dart';

abstract class NotificationProvider {
  Future<void> init();

  Future<void> showNotification(ReqResUser user);
}

class NotificationProviderImpl implements NotificationProvider {
  static bool _init = true;

  NotificationProviderImpl() {
    if (_init) {
      init();
      _init = false;
    }
  }
  @override
  Future<void> init() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: APP_NOTIFICATION_CHANNEL_KEY,
          channelName: APP_NOTIFICATION_CHANNEL_NAME,
          channelDescription: APP_NOTIFICATION_CHANNEL_DESCRIPTION,
          channelGroupKey: APP_NOTIFICATION_CHANNEL_GROUP_KEY,
          enableVibration: true,
          defaultColor: Colors.white,
          ledColor: Colors.blue,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: APP_NOTIFICATION_CHANNEL_GROUP_KEY,
          channelGroupName: APP_NOTIFICATION_CHANNEL_GROUP_NAME,
        ),
      ],
    );

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
    );
  }

  @override
  Future<void> showNotification(ReqResUser user) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: user.id,
        channelKey: APP_NOTIFICATION_CHANNEL_KEY,
        title: "${user.firstName} ${user.lastName}",
        body: "This user was viewed...",
        actionType: ActionType.Default,
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  Future<void> _onActionReceivedMethod(ReceivedAction receivedAction) async {}
}

final notifProvider = Provider((r) => NotificationProviderImpl());
