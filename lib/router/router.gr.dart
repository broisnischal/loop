// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:loop/features/index/presentation/screens/add_habit.dart' as _i1;
import 'package:loop/features/index/presentation/screens/home.dart' as _i2;
import 'package:loop/features/index/presentation/screens/stats.dart' as _i3;

/// generated route for
/// [_i1.AddHabit]
class AddHabitRoute extends _i4.PageRouteInfo<void> {
  const AddHabitRoute({List<_i4.PageRouteInfo>? children})
    : super(AddHabitRoute.name, initialChildren: children);

  static const String name = 'AddHabitRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddHabit();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomePageRoute extends _i4.PageRouteInfo<void> {
  const HomePageRoute({List<_i4.PageRouteInfo>? children})
    : super(HomePageRoute.name, initialChildren: children);

  static const String name = 'HomePageRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.StatsPage]
class StatsRoute extends _i4.PageRouteInfo<void> {
  const StatsRoute({List<_i4.PageRouteInfo>? children})
    : super(StatsRoute.name, initialChildren: children);

  static const String name = 'StatsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.StatsPage();
    },
  );
}
