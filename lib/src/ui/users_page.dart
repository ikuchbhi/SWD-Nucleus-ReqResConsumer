import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/user_tile.dart';
import '../ui/error.dart';
import '../providers/req_res_user_provider.dart';

class UsersPage extends ConsumerWidget {
  UsersPage({super.key});

  final userProvider = FutureProvider(
    (ref) => ReqResUserProviderImpl().getUsers(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final up = ref.watch(userProvider);
    return up.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, _) => Center(child: Error(error)),
      data: (reqresusers) {
        return ListView.builder(
          itemCount: reqresusers.length,
          itemBuilder: (context, index) {
            if (reqresusers.isEmpty) {
              return const Error("No user exists");
            }
            return UserTile(user: reqresusers[index]);
          },
        );
      },
    );
  }
}
