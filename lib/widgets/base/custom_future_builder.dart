import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sporty/customs/custom_applications.dart';

import 'loading_widget.dart';

class CustomFutureBuilder<T> extends StatefulWidget {
  Widget Function(Object)? child;
  Future<T>? future;

  CustomFutureBuilder({super.key, this.child, this.future});

  @override
  _CustomFutureBuilderState createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: widget.future as Future<T>,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: 1050.ms,
              child: snapshot.connectionState == ConnectionState.waiting
                  ? AnimatedContainer(
                      duration: 850.ms,
                      curve: Curves.easeOutExpo,
                      height: 350,
                      child: LoadingWidget())
                  : (widget.child == null
                      ? Container()
                      : widget.child!(snapshot.data!)));
        });
  }
}
