import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/req_res_user.dart';
import '../providers/notifications/notification_provider.dart';
import 'user_info.dart';

class UserTile extends ConsumerStatefulWidget {
  final ReqResUser user;
  final int? id;
  const UserTile({super.key, required this.user, this.id});

  @override
  ConsumerState<UserTile> createState() => _UserTileState();
}

class _UserTileState extends ConsumerState<UserTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 2.0,
        margin: const EdgeInsets.all(5.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60.0,
                width: 45.0,
                margin: const EdgeInsets.only(right: 15.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                child: CircleAvatar(
                  radius: 30.0,
                  foregroundImage: NetworkImage(widget.user.avatarUrl),
                  child: const Icon(Icons.person),
                ),
              ),
              Text(
                "${widget.user.firstName} ${widget.user.lastName}",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.chevron_right_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  ref.read(notifProvider).showNotification(widget.user);
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (c) => UserInfo(user: widget.user),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showUserInfo(ReqResUser user) => showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (c) => UserInfo(user: user),
      );
}
