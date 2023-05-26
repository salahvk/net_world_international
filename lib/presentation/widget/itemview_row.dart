import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class ItemViewRow extends StatelessWidget {
  final String key1;
  final String value;
  const ItemViewRow({super.key, required this.key1, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key1,
            style: getRegularStyle(color: Colormanager.textColor, fontSize: 14),
          ),
          Text(
            value,
            style: getRegularStyle(color: Colormanager.textColor, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
