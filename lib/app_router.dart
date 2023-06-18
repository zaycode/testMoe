import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_page.dart';
import 'pages/projects/_view/projects_page.dart';
import 'pages/tasks/_view/tasks_page.dart';
import 'pages/teams/_view/teams_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/tasks',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, pageBuilder) {
        return HomePage(pageBuilder: pageBuilder);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tasks',
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: TasksPage()),
              routes: [
                GoRoute(
                  path: ':id',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: TasksPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/projects',
              pageBuilder: (context, state) => NoTransitionPage(
                child: ProjectsPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/teams',
              pageBuilder: (context, state) => NoTransitionPage(
                child: TeamsPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
