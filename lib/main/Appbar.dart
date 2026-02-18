import 'package:flutter/material.dart';
import 'package:flutter_assignment/main/Profile.dart';

class CommonAppBar extends StatelessWidget
  implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Text(title),
      actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
            },
            icon: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/profile.png'),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          ),
      ],
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
