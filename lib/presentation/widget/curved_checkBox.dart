import 'package:flutter/material.dart';
import 'package:net_world_international/core/color_manager.dart';
import 'package:net_world_international/core/styles_manager.dart';

class CurvedCheckbox extends StatefulWidget {
  final bool value;
  final String text;
  final ValueChanged<bool> onChanged;

  const CurvedCheckbox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text
  }) : super(key: key);

  @override
  State<CurvedCheckbox> createState() => _CurvedCheckboxState();
}

class _CurvedCheckboxState extends State<CurvedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Padding(
        padding:const EdgeInsets.only(left: 8,top: 8,bottom: 8),
        child: Row(
          children: [
            Padding(
              padding:    const EdgeInsets.only(right: 3),
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
                            )
                          : const SizedBox(
                              height: 15,
                              width: 15,
                            ),
                    ),
                  ),
                ),
              ),
            ),  Text(
                                              widget.text,
                                              style: getRegularStyle(
                                                  color: Colormanager.textColor,
                                                  fontSize: 10),
                                            ),
          ],
        ),
      ),
    );
  }
}

