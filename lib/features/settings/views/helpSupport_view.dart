import 'package:flutter/material.dart';
import 'package:flutter_assignment/features/settings/viewmodels/FAQ_viewmodel.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final HelpSupportViewModel vm = HelpSupportViewModel();

  @override
  void initState() {
    super.initState();
    vm.addListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    vm.removeListener(_refresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: vm.helpItems.length,
          itemBuilder: (context, index) {
            final item = vm.helpItems[index];
            final expanded = vm.isExpanded(index);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(item.question),
                    trailing: Icon(
                      expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    ),
                    onTap: () {
                      vm.toggleItem(index);
                    },
                  ),

                  if (expanded)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item.answer),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}