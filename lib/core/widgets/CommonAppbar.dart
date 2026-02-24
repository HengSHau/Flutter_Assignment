import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/profile/views/profile_view.dart';

class CommonAppBar extends StatelessWidget
  implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showProfile;
  final List<Widget>? actions;

  CommonAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.showProfile = true,
    this.actions,
    required this.themeNotifier
  });

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBack
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )
        : null,
      title: Text(title),
      actions: showProfile
        ? [IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(themeNotifier: themeNotifier),
              ),
            );
          },
          icon: CircleAvatar(
            radius: 18,
            backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
            child: Icon(
              Icons.person,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        )]
      : null,
    );
  }
}

BottomNavigationBar buildBottomNavBar({
  required int currentIndex,
  required ValueChanged<int> onTap,
}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    type: BottomNavigationBarType.fixed, 
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.functions),
        label: 'Functions',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
  );
}
