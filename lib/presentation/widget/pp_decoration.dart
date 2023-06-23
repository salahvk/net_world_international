import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';

BoxDecoration buildPpDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.5),
    border: Border.all(
      color: Colormanager.primary,
      width: 1.0,
    ),
  );
}
