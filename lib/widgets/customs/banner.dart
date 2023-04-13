import 'package:flutter/material.dart';
import 'package:sporty/customs/custom_applications.dart';


class CustomApplicationBanner extends StatelessWidget {
  Widget? child;

  CustomApplicationBanner({this.child, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Banner(
            location: BannerLocation.topStart,
            message: CustomApplication.name,
            color: Colors.green.withOpacity(0.6),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                letterSpacing: 1.0),
            textDirection: TextDirection.ltr,
            child: child,
          );
        
  }
}
