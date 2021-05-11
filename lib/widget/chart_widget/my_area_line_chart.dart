import 'package:fl_animated_linechart/chart/chart_line.dart';
import 'package:fl_animated_linechart/chart/datetime_series_converter.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:fl_animated_linechart/common/dates.dart';
import 'package:fl_animated_linechart/common/pair.dart';
import 'package:flutter/rendering.dart';

import 'my_line_chart.dart';

class MyAreaLineChart extends MyLineChart {
  Map<int, Path> _areaPathMap = Map();

  final List<Pair<Color, Color>> _gradients;

  MyAreaLineChart(List<ChartLine> lines, Dates fromTo, this._gradients)
      : super(lines, fromTo);

  factory MyAreaLineChart.fromDateTimeMaps(List<Map<DateTime, double>> series,
      List<Color> colors, List<String> units,
      {List<Pair<Color, Color>> gradients}) {
    assert(series.length == colors.length);
    assert(series.length == units.length);

    Pair<List<ChartLine>, Dates> convertFromDateMaps =
    DateTimeSeriesConverter.convertFromDateMaps(series, colors, units);
    return MyAreaLineChart(
        convertFromDateMaps.left, convertFromDateMaps.right, gradients);
  }

  List<Pair<Color, Color>> get gradients => _gradients;

  Path getAreaPathCache(int index) {
    if (_areaPathMap.containsKey(index)) {
      return _areaPathMap[index];
    } else {
      Path pathCache = getPathCache(index);

      Path areaPath = Path();
      areaPath.moveTo(pathCache.getBounds().left, pathCache.getBounds().bottom);
      areaPath.addPath(pathCache, Offset(0, 0));

      areaPath.lineTo(
          pathCache.getBounds().right, pathCache.getBounds().bottom);
      areaPath.lineTo(pathCache.getBounds().left, pathCache.getBounds().bottom);

      _areaPathMap[index] = areaPath;
      return areaPath;
    }
  }
}
