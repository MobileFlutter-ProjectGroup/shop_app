import 'package:flutter/material.dart';

class MyBadge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;
  final Color? textColor;
  const MyBadge({
    required this.child,
    required this.value,
    this.color,
    this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: textColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
