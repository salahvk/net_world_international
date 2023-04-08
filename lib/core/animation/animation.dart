// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// // define animated properties
// enum AniProps { opacity, translateY }

// //function to animate opacity and position on the Y axis
// class FadeCustomAnimation extends StatelessWidget {
//   final double delay;
//   final Widget? child;
//   final bool fromBottom;

//   const FadeCustomAnimation(
//       {super.key, this.delay = 1, this.child, this.fromBottom = false});

//   @override
//   Widget build(BuildContext context) {
//     // final tween = TimelineTween<AniProps>()
//     //   ..addScene(
//     //           begin: const Duration(milliseconds: 0),
//     //           duration: const Duration(milliseconds: 500))
//     //       .animate(AniProps.opacity, tween: Tween<double>(begin: 0.0, end: 1.0))
//     //       .animate(AniProps.translateY,
//     //           tween: Tween<double>(begin: fromBottom ? 30.0 : -30.0, end: 0.0));

//     final movieTween = MovieTween()
//       ..scene(
//               begin: const Duration(seconds: 0),
//               end: const Duration(seconds: 1))
//           .tween(Props.width, Tween(begin: 0.0, end: 100.0),
//               curve: Curves.easeIn)
//       ..scene(
//               begin: const Duration(seconds: 1),
//               end: const Duration(seconds: 3))
//           .tween(Props.width, Tween(begin: 100.0, end: 200.0),
//               curve: Curves.easeOut)
//       ..scene(
//               begin: const Duration(seconds: 0),
//               end: const Duration(seconds: 3))
//           .tween(Props.color, ColorTween(begin: Colors.red, end: Colors.blue));

//     // return PlayAnimation<TimelineValue<AniProps>>(
//     //   delay: Duration(milliseconds: (500 * delay).round()),
//     //   duration: tween.duration,
//     //   tween: tween,
//     //   // curve: Curves.easeInExpo,
//     //   child: child,
//     //   builder: (context, child, animation) => Opacity(
//     //     opacity: animation.get(AniProps.opacity),
//     //     child: Transform.translate(
//     //         offset: Offset(0, animation.get(AniProps.translateY)),
//     //         child: child),
//     //   ),
//     // );
//   }
// }

// //function to animate opacity and position on the X axis
// class FadeSlideCustomAnimation extends StatelessWidget {
//   final double delay;
//   final Widget? child;
//   bool isRight;

//   FadeSlideCustomAnimation(
//       {super.key, this.delay = 1, this.child, this.isRight = false});

//   @override
//   Widget build(BuildContext context) {
//     final tween = isRight
//         ? (TimelineTween<AniProps>()
//           ..addScene(
//                   begin: const Duration(milliseconds: 0),
//                   duration: const Duration(milliseconds: 500))
//               .animate(AniProps.opacity,
//                   tween: Tween<double>(end: 1.0, begin: 0.0))
//               .animate(AniProps.translateY,
//                   tween: Tween<double>(end: 0.0, begin: 30.0)))
//         : (TimelineTween<AniProps>()
//           ..addScene(
//                   begin: const Duration(milliseconds: 0),
//                   duration: const Duration(milliseconds: 500))
//               .animate(AniProps.opacity,
//                   tween: Tween<double>(begin: 0.0, end: 1.0))
//               .animate(AniProps.translateY,
//                   tween: Tween<double>(begin: -30.0, end: 0.0)));

//     return PlayAnimation<TimelineValue<AniProps>>(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builder: (context, child, animation) => Opacity(
//         opacity: animation.get(AniProps.opacity),
//         child: Transform.translate(
//             offset: Offset(animation.get(AniProps.translateY), 0),
//             child: child),
//       ),
//     );
//   }
// }
