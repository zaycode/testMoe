import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/common/app_style.dart';

class AppNavigationBar extends ConsumerWidget {
  AppNavigationBar({
    Key? key,
    this.currentIndex = 0,
    this.onItemTapped,
  }) : super(key: key);

  final int currentIndex;
  final ValueChanged<int>? onItemTapped;
  final navigationList = [
    NavigationBarItem(name: 'tasks', url: 'tasks'),
    NavigationBarItem(name: 'projects', url: 'projects'),
    NavigationBarItem(name: 'teams', url: 'teams'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef watch) {
    bool isEnSelected = context.locale.languageCode == "en";
    return ColoredBox(
      color: AppStyle.darkBlue,
      child: Column(
        children: [
          SizedBox(height: 32),
          CupertinoSlidingSegmentedControl<int>(
            backgroundColor: Colors.white,
            thumbColor: AppStyle.darkBlue,
            children: {
              0: DefaultTextStyle(
                style:
                    isEnSelected ? TextStyle(color: Colors.white) : TextStyle(),
                child: Text('English'),
              ),
              1: DefaultTextStyle(
                style: !isEnSelected
                    ? TextStyle(color: Colors.white)
                    : TextStyle(),
                child: Text('العربية'),
              ),
            },
            onValueChanged: (index) {
              final newLocale = index == 0 ? Locale('en') : Locale('ar');
              context.setLocale(newLocale);
            },
            groupValue: isEnSelected ? 0 : 1,
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 64),
              itemCount: navigationList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onItemTapped?.call(index),
                  child: _NavigationBarListItem(
                    isSelected: index == currentIndex,
                    title: navigationList[index].name.tr(),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: AppStyle.mediumBlue,
                height: 1,
                endIndent: 16,
                indent: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarListItem extends StatelessWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.title,
    required this.isSelected,
  }) : super(key: key);
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected == true ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppStyle.darkBlue : AppStyle.lightTextColor,
          fontSize: 18,
        ),
      ),
    );
  }
}

class NavigationBarItem {
  final String name;
  final String url;

  NavigationBarItem({required this.name, required this.url});
}
