import 'package:flutter/material.dart';
import 'package:reqres_consumer/src/models/req_res_user.dart';

import 'user_info.dart';

class UserTile extends StatefulWidget {
  final ReqResUser user;
  const UserTile({super.key, required this.user});

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.all(5.0),
        // shadowColor: Colors.grey[600],
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
                  // color: Colors.grey[900],
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                  // border: Border.all(
                  //   // color: Colors.grey[900]!,
                  //   width: 5.0,
                  // ),
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
                icon: const Icon(Icons.chevron_right_outlined),
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (c) => UserInfo(user: widget.user),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
