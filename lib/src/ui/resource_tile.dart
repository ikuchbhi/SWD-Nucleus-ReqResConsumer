import 'package:flutter/material.dart';

import '../models/req_res_resource.dart';
import 'resource_info.dart';

class ResourceTile extends StatefulWidget {
  final ReqResResource resource;
  const ResourceTile({super.key, required this.resource});

  @override
  State<ResourceTile> createState() => _ResourceTileState();
}

class _ResourceTileState extends State<ResourceTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Card(
        key: ValueKey(widget.resource),
        color: Theme.of(context).cardColor,
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 110.0,
              color: _getColor(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Name: ${widget.resource.name}"),
                Text("Year: ${widget.resource.year}"),
                Chip(
                  label: Text(widget.resource.pantoneValue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    var hex = widget.resource.color.toUpperCase().replaceAll("#", "");
    return Color(int.parse("0xFF$hex"));
  }
}
