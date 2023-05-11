import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/req_res_resource.dart';
import 'req_res_resource_provider.dart';

class ReqResResources extends StateNotifier<List<ReqResResource?>> {
  final ReqResResourceProvider provider;

  ReqResResources(this.provider) : super([]);

  Future<ReqResResource?> getResource(int resourceNumber) async {
    final res = await provider.getResource(resourceNumber);
    if (state.length < 10) {
      state = [...state, res];
    }
    return res;
  }
}

final resourcesprovider = Provider((_) => ReqResResourceProviderImpl());

final resourceProvider =
    StateNotifierProvider<ReqResResources, List<ReqResResource?>>(
  (ref) => ReqResResources(
    ref.read(resourcesprovider),
  ),
);
