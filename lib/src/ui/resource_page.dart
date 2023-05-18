import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/req_res_resource.dart';
import '../ui/resource_tile.dart';
import '../providers/resource/req_res_resource.dart';
import 'resource_info.dart';

class ResourcesPage extends ConsumerStatefulWidget {
  const ResourcesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends ConsumerState<ResourcesPage> {
  final CarouselController _controller = CarouselController();
  bool isLoading = true;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getData());
  }

  @override
  Widget build(BuildContext context) {
    final resources = ref.watch(resourceProvider);
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () => _controller.previousPage(),
                          child: const Icon(
                            Icons.arrow_left_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () => _controller.nextPage(),
                          child: const Icon(
                            Icons.arrow_right_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AbsorbPointer(
                  absorbing: true,
                  child: CarouselSlider(
                    disableGesture: true,
                    items: resources
                        .map(
                          (r) => ResourceTile(
                            resource: ReqResResource(
                              id: r!.id,
                              name: r.name,
                              year: r.year,
                              color: r.color,
                              pantoneValue: r.pantoneValue,
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 200,
                      onPageChanged: (i, _) {
                        setState(() => _current = i);
                      },
                    ),
                    carouselController: _controller,
                  ),
                ),
                const Divider(),
                ResourceInfo(resource: resources[_current]!),
              ],
            ),
    );
  }

  void _getData() async {
    int i = 1;
    while (i < 15) {
      var ans = await ref.watch(resourceProvider.notifier).getResource(i);
      if (ans == null) {
        setState(() => isLoading = false);
        break;
      }
      i++;
    }
  }
  // );
}
