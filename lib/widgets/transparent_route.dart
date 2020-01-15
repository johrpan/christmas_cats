import 'package:flutter/material.dart';

// This is a modified version of MaterialPageRoute that we can't extend without
// hitting an assertion.
class TransparentRoute<T> extends PageRoute<T> {
  final Widget Function(BuildContext context) builder;

  MaterialPageRoute route;

  TransparentRoute({
    this.builder,
  });

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}
