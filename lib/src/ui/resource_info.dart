import 'package:flutter/material.dart';

import '../models/req_res_resource.dart';

class ResourceInfo extends StatelessWidget {
  final ReqResResource resource;
  const ResourceInfo({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          color: _getColor(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                resource.name,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Chip(
                    label: Text(
                      resource.color,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      "Year: ${resource.year}",
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(
                      resource.pantoneValue,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getColor() {
    var hex = resource.color.toUpperCase().replaceAll("#", "0xFF");
    return Color(int.parse(hex));
  }
}
