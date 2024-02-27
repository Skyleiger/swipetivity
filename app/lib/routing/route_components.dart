import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Abstract GoRouteData class that should be used for all child routes inside a shell route.
/// It disables the transition for the child route.
@immutable
abstract class ShellChildRoute extends GoRouteData {
  const ShellChildRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return NoTransitionPage(child: build(context, state));
  }
}

@immutable
abstract class BottomSheetRoute extends GoRouteData {
  final Color? backgroundColor;
  final String? barrierLabel;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? barrierColor;
  final bool isScrollControlled;
  final double scrollControlDisabledMaxHeightRatio;
  final bool useRootNavigator;
  final bool isDismissible;
  final bool enableDrag;
  final bool? showDragHandle;
  final bool useSafeArea;
  final RouteSettings? routeSettings;
  final AnimationController? transitionAnimationController;
  final Offset? anchorPoint;

  const BottomSheetRoute({
    this.backgroundColor,
    this.barrierLabel,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    this.isScrollControlled = true,
    this.scrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
    this.useRootNavigator = false,
    this.isDismissible = true,
    this.enableDrag = true,
    this.showDragHandle,
    this.useSafeArea = false,
    this.routeSettings,
    this.transitionAnimationController,
    this.anchorPoint,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return BottomSheetPage(
      context: context,
      builder: (context) => build(context, state),
      backgroundColor: backgroundColor,
      barrierLabel: barrierLabel,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      scrollControlDisabledMaxHeightRatio: scrollControlDisabledMaxHeightRatio,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
    );
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Wrap(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: buildSheet(context, state),
          ),
        ),
      ],
    );
  }

  Widget buildSheet(BuildContext context, GoRouterState state);
}

@immutable
class BottomSheetPage<T> extends Page<T> {
  final BuildContext context;
  final WidgetBuilder builder;
  final Color? backgroundColor;
  final String? barrierLabel;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? barrierColor;
  final bool isScrollControlled;
  final double scrollControlDisabledMaxHeightRatio;
  final bool useRootNavigator;
  final bool isDismissible;
  final bool enableDrag;
  final bool? showDragHandle;
  final bool useSafeArea;
  final RouteSettings? routeSettings;
  final AnimationController? transitionAnimationController;
  final Offset? anchorPoint;

  const BottomSheetPage({
    required this.context,
    required this.builder,
    this.backgroundColor,
    this.barrierLabel,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    this.isScrollControlled = false,
    this.scrollControlDisabledMaxHeightRatio = 9.0 / 16.0,
    this.useRootNavigator = false,
    this.isDismissible = true,
    this.enableDrag = true,
    this.showDragHandle,
    this.useSafeArea = false,
    this.routeSettings,
    this.transitionAnimationController,
    this.anchorPoint,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      builder: builder,
      capturedThemes: InheritedTheme.capture(
          from: context,
          to: Navigator.of(context, rootNavigator: useRootNavigator).context),
      isScrollControlled: isScrollControlled,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      enableDrag: enableDrag,
      settings: this,
      // This is important and needs to be like this
      transitionAnimationController: transitionAnimationController,
    );
  }
}
