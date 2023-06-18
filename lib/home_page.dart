import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/app_navigation_bar.dart';

// This class does not have to be used. It should be replaced with class
// handling navigation using go_router package
class HomePage extends StatelessWidget {
  final StatefulNavigationShell pageBuilder;

  const HomePage({Key? key, required this.pageBuilder}) : super(key: key);

  void onNavigate(int index) {
    pageBuilder.goBranch(
      index,
      initialLocation: index == pageBuilder.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              maxWidth: 300,
            ),
            child: AppNavigationBar(
              onItemTapped: onNavigate,
              currentIndex: pageBuilder.currentIndex,
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: pageBuilder)),
        ],
      ),
    );
  }
}
