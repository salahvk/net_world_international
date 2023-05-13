import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';

showAnimatedSnackBar(BuildContext context, String text, {type}) {
  AnimatedSnackBar.material(text,
          type: AnimatedSnackBarType.error,
          borderRadius: BorderRadius.circular(6),
          duration: const Duration(seconds: 1))
      .show(
    context,
  );
}

showSuccessAnimatedSnackBar(BuildContext context, String text, {type}) {
  AnimatedSnackBar.material(text,
          type: AnimatedSnackBarType.success,
          borderRadius: BorderRadius.circular(6),
          duration: const Duration(seconds: 1))
      .show(
    context,
  );
}
