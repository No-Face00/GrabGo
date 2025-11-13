import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../text/support_widget.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarWidget({super.key, this.title = "GrabGo"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      title: Text(
        title,
        style: AppText.boldTextFieldStyle(),
      ),
      elevation: 8,
      shadowColor: secondaryColor,
      centerTitle: true,
      // ✅ Only bottom corners are rounded
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          // ✅ Match shape here as well
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  /// 👇 required by PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}