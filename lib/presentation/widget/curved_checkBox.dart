import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';

class CurvedCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CurvedCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CurvedCheckboxState createState() => _CurvedCheckboxState();
}

class _CurvedCheckboxState extends State<CurvedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.value ? Colors.red : Colors.white,
          border: Border.all(
            color: Colormanager.primary,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: widget.value ? Colors.red : Colors.transparent,
              child: widget.value
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      // child: Icon(
                      //   Icons.check,
                      //   size: 12.0,
                      //   color: Colors.white,
                      // ),
                    )
                  : const SizedBox(
                      height: 15,
                      width: 15,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
