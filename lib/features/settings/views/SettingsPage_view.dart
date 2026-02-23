import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key,required this.themeNotifier,});
  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool get isDark => widget.themeNotifier.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[ 
            const SizedBox( 
              width: 150, 
              child: Icon(Icons.settings, size: 100) 
            ), 

            const SizedBox(height: 25), 

            ElevatedButton.icon( 
              onPressed: () {}, 
              icon: const Icon( Icons.question_mark, size: 16, ), 
              label: const Text( 
                'Help & Support', 
                style: TextStyle( 
                  fontSize: 12, fontWeight: FontWeight.bold, 
                ), 
              ), 
            ), 

            const SizedBox(height: 20),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Dark Mode:'),
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    widget.themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                ),
              ],
            )
          ]
          ),
        ),
      )  
    );
  }
}