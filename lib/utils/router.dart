import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_order/ui/pages/history/history.dart';
import 'package:pos_order/ui/pages/init_page.dart';
import 'package:pos_order/ui/pages/order/order.dart';
import 'package:pos_order/ui/pages/tables/details.dart';
import 'package:pos_order/ui/pages/tables/tables.dart';
import 'package:pos_order/ui/pages/scaffold_base.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    observers: [GoRouterObserver()],
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const InitPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldBase(navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/tables',
                builder: (context, state) => const TablesPage(),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'details',
                    builder: (context, state) {
                      return const DetailsPage();
                    },
                  )
                ],
              ),
            ],
          ),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/order',
              builder: (context, state) => const OrderPage(),
            ),
          ]),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              path: '/history',
              builder: (context, state) => const HistoryPage(),
            ),
          ])
        ],
      ),
    ],
  );
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route');
    log('MyTest didPush pref: $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyTest didReplace: $newRoute');
  }
}
