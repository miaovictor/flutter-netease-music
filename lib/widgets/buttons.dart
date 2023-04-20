import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  AppIconButton({
    super.key,
    required IconData icon,
    this.size = 24,
    this.onPressed,
    this.enable = true,
    this.color,
    this.disabledColor,
    this.tooltip,
    this.padding = const EdgeInsets.all(8),
  }) : icon = Icon(icon);

  const AppIconButton.widget({
    super.key,
    required this.icon,
    this.size = 24,
    this.onPressed,
    this.enable = true,
    this.color,
    this.disabledColor,
    this.tooltip,
    this.padding = const EdgeInsets.all(8),
  });

  final Widget icon;
  final double size;
  final VoidCallback? onPressed;
  final bool enable;
  final Color? color;
  final Color? disabledColor;

  final String? tooltip;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: enable ? (onPressed ?? () {}) : null,
    icon: icon,
    iconSize: size,
    color: color ?? IconTheme.of(context).color,
    disabledColor: disabledColor,
    splashRadius: size,
    tooltip: tooltip,
    mouseCursor:
    enable ? SystemMouseCursors.click : SystemMouseCursors.basic,
    padding: padding,
  );
}