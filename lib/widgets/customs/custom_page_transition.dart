import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSportyTransition implements CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    animation = CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);

    return Builder(
      builder: (innerContext) => Stack(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ],
      ),
    );
  }
}

// class CustomPageRoute extends PageRouteBuilder {
//   final Widget widget;
//   final Widget? current;

//   CustomPageRoute({required this.widget, this.current})
//       : super(
//           maintainState: true,
//           transitionDuration: 1280.ms,
//           transitionsBuilder: (BuildContext context,
//               Animation<double> animation,
//               Animation<double> secAnimation,
//               Widget child) {
//             animation =
//                 CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);

//             return Builder(
//               builder: (innerContext) => Stack(
//                 children: [
//                   SlideTransition(
//                     position: Tween<Offset>(
//                       begin: const Offset(1.0, 0.0),
//                       end: Offset.zero,
//                     ).animate(animation),
//                     child: widget,
//                   ),
//                 ],
//               ),
//             );
//           },
//           pageBuilder: (BuildContext context, Animation<double> animation,
//               Animation<double> secAnimation) {
//             if (current != null) {
//               return current;
//             } else {
//               return Container();
//             }
//           },
//         );
// }
