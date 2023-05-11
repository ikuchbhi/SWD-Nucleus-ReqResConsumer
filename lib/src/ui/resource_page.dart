import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_consumer/src/providers/req_res_resource.dart';
import 'package:reqres_consumer/src/ui/resource_tile.dart';

class ResourcesPage extends ConsumerStatefulWidget {
  const ResourcesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends ConsumerState<ResourcesPage> {
  int _rNo = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resources = ref.watch(resourceProvider);
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container();
      },
      itemCount: resources.length + 1,
      shrinkWrap: true,
    );
  }
  // );
}
