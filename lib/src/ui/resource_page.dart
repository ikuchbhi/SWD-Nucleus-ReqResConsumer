import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reqres_consumer/src/models/req_res_resource.dart';
import 'package:reqres_consumer/src/ui/resource_tile.dart';
import '../providers/resource/req_res_resource.dart';

class ResourcesPage extends ConsumerStatefulWidget {
  const ResourcesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResourcesPageState();
}

class _ResourcesPageState extends ConsumerState<ResourcesPage> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resources = ref.watch(resourceProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            CarouselSlider(
              disableGesture: true,
              items: List.generate(
                10,
                (r) => ResourceTile(
                  resource: ReqResResource(
                    id: r,
                    name: r.toString(),
                    year: r + 2000,
                    color: "#E91E63",
                    pantoneValue: "17-2031",
                  ),
                ),
              ),
              options: CarouselOptions(enlargeCenterPage: true, height: 200),
              carouselController: _controller,
            ),
          ],
        ),
      ),
    );
  }
  // );
}
