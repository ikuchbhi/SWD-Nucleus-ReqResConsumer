import 'package:flutter/material.dart';

import '../models/req_res_user.dart';

class UserInfo extends StatelessWidget {
  final ReqResUser user;
  const UserInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                // color: Colors.pink,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade700,
                      Colors.indigo.shade200,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 30.0 + MediaQuery.of(context).size.height * 0.03,
                ),
                color: Colors.grey.shade200,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Email: ${user.email}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.075,
            top: MediaQuery.of(context).size.height * 0.035,
            child: CircleAvatar(
              radius: 60.0,
              foregroundImage: NetworkImage(user.avatarUrl),
              child: const Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }
}
