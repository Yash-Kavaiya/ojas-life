import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class OjasAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OjasAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showDivider = false,
    this.transparent = false,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showDivider;
  final bool transparent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: OjasTextStyles.headlineMedium),
      actions: actions,
      leading: leading,
      backgroundColor: transparent ? Colors.transparent : OjasColors.deepPurple,
      elevation: showDivider ? 1 : 0,
      shadowColor: OjasColors.cardPurple,
    );
  }
}
