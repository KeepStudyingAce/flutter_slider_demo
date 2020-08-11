import 'dart:math';

import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({
    this.controller,
    this.itemCount: 0,
  }) : assert(controller != null);

  /// PageView的控制器
  final PageController controller;

  /// 指示器的个数
  final int itemCount;

  /// 普通的颜色
  final Color normalColor = Colors.grey;

  /// 选中的颜色
  final Color selectedColor = Colors.white;

  /// 点的大小
  final double size = 8.0;

  /// 点的间距
  final double spacing = 5.0;

  /// 点的Widget
  Widget _buildIndicator(
      int index, int pageCount, double dotSize, double spacing) {
    // 是否是当前页面被选中
    bool isCurrentPageSelected = index ==
        (controller.page != null ? controller.page.round() % pageCount : 0);

    return new Container(
      height: max(size, dotSize + 4),
      width: size + (2 * spacing),
      child: new Center(
        child: new Material(
          color: isCurrentPageSelected ? selectedColor : normalColor,
          type: MaterialType.circle,
          child: new Container(
            width: isCurrentPageSelected ? dotSize + 1 : dotSize,
            height: isCurrentPageSelected ? dotSize + 1 : dotSize,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, (int index) {
        return _buildIndicator(index, itemCount, size, spacing);
      }),
    );
  }
}
