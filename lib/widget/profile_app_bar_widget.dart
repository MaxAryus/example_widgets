import 'package:flutter/material.dart';

class ProfileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileAppBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;

    // Determine if the device is mobile based on the screen width
    bool isMobile = 540 >= MediaQuery.of(context).size.width;

    return Material(
      color: isMobile ? backgroundColor : Colors.white,
      elevation: isMobile ? 0 : 4.0,
      child: AppBar(
        foregroundColor: isMobile ? Colors.white : Colors.black,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isMobile ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        centerTitle: isMobile,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
