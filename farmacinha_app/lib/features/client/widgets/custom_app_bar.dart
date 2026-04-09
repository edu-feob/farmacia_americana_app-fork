import 'package:flutter/material.dart';
import 'package:farmacia_app/core/palette/pallete.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    this.onLogoTap,
    this.onMenuTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Pallete.whiteColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Pallete.primaryRed,
        ),
        onPressed: onMenuTap,
      ),
      title: GestureDetector(
        onTap: onLogoTap,
        child: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Farmácia ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Pallete.primaryRed,
                ),
              ),
              TextSpan(
                text: 'Americana',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Pallete.accentYellow,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: Pallete.primaryRed,
          ),
          onPressed: onNotificationTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}