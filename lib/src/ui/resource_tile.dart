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
                  foregroundColor: _getColor(),
                  child: const Icon(Icons.person),
                ),
              ),
              Text(
                widget.resource.name,
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
                onPressed: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (c) => ResourceInfo(resource: widget.resource),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    var hex = widget.resource.color.toUpperCase().replaceAll("#", "");
    return Color(int.parse(hex, radix: 16));
  }
}
