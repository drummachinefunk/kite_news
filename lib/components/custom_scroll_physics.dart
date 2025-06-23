import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom scroll physics that apply a bouncing effect only on the bottom edge.
class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({
    this.decelerationRate = ScrollDecelerationRate.normal,
    super.parent,
  });

  final ScrollDecelerationRate decelerationRate;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(
      parent: buildParent(ancestor),
      decelerationRate: decelerationRate,
    );
  }

  double _frictionFactor(double overscrollFraction) {
    return math.pow(1 - overscrollFraction, 2) *
        switch (decelerationRate) {
          ScrollDecelerationRate.fast => 0.26,
          ScrollDecelerationRate.normal => 0.52,
        };
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!position.outOfRange) {
      return offset;
    }

    final double overscrollPastStart = math.max(
      position.minScrollExtent - position.pixels,
      0.0,
    );
    final double overscrollPastEnd = math.max(
      position.pixels - position.maxScrollExtent,
      0.0,
    );
    final double overscrollPast = math.max(
      overscrollPastStart,
      overscrollPastEnd,
    );
    final bool easing =
        (overscrollPastStart > 0.0 && offset < 0.0) ||
        (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction =
        easing
            // Apply less resistance when easing the overscroll vs tensioning.
            ? _frictionFactor(
              (overscrollPast - offset.abs()) / position.viewportDimension,
            )
            : _frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    if (easing && decelerationRate == ScrollDecelerationRate.fast) {
      return direction * offset.abs();
    }
    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
    double extentOutside,
    double absDelta,
    double gamma,
  ) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) {
        return absDelta * gamma;
      }
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      // Underscroll.
      return value - position.pixels;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final Tolerance tolerance = toleranceFor(position);
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
        constantDeceleration: switch (decelerationRate) {
          ScrollDecelerationRate.fast => 1400,
          ScrollDecelerationRate.normal => 0,
        },
      );
    }
    return null;
  }

  @override
  double get minFlingVelocity => kMinFlingVelocity * 2.0;

  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(
          0.000816 * math.pow(existingVelocity.abs(), 1.967).toDouble(),
          40000.0,
        );
  }

  @override
  double get dragStartDistanceMotionThreshold => 3.5;

  @override
  double get maxFlingVelocity => switch (decelerationRate) {
    ScrollDecelerationRate.fast => kMaxFlingVelocity * 8.0,
    ScrollDecelerationRate.normal => super.maxFlingVelocity,
  };

  @override
  SpringDescription get spring {
    switch (decelerationRate) {
      case ScrollDecelerationRate.fast:
        return SpringDescription.withDampingRatio(
          mass: 0.3,
          stiffness: 75.0,
          ratio: 1.3,
        );
      case ScrollDecelerationRate.normal:
        return super.spring;
    }
  }
}
