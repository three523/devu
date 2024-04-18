import 'package:flutter/material.dart';

class PagingScrollPhysics extends ScrollPhysics {
  const PagingScrollPhysics(
      {required this.itemCount, required this.viewSize, super.parent});

  final double viewSize;

  final int itemCount;

  @override
  PagingScrollPhysics applyTo(ScrollPhysics? ancestor) => PagingScrollPhysics(
      itemCount: itemCount, viewSize: viewSize, parent: buildParent(ancestor));

  double _getPage(double current, double itemDimension) =>
      current / itemDimension;

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    // plus view size because the max scroll extent is about where the screen
    //  starts not where the screen ends.
    final pixels = position.maxScrollExtent + viewSize;
    final itemDimension = pixels / itemCount;
    var page = _getPage(position.pixels, itemDimension);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    final pageRound = page.round();
    final itemsPerPage = viewSize ~/ itemDimension;
    final showingLastItem = pageRound == itemCount - itemsPerPage;
    if (showingLastItem) return pixels - viewSize;

    return pageRound * itemDimension;
  }
}
