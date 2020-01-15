import 'package:flutter/material.dart';

class MenuEntry extends StatelessWidget {
  final String text;
  final void Function() onTap;

  MenuEntry({
    @required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              height: 1.1,
            ),
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
