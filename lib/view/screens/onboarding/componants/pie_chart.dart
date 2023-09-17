



import 'package:flutter/cupertino.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/componants/painter.dart';
import 'package:ride_sharing_user_app/view/screens/onboarding/model/pie_chard_model.dart';


class PieChart extends StatelessWidget {
  PieChart({
    required this.data,
    required this.radius,
    this.strokeWidth = 8,
    this.child,
    Key? key,
  })  : // make sure sum of data is never ovr 100 percent
        assert(data.fold<double>(0, (sum, data) => sum + data.percent) <= 100),
        super(key: key);

  final List<PieChartData> data;

  // radius of chart
  final double radius;

  // width of stroke
  final double strokeWidth;

  // optional child; can be used for text for example
  final Widget? child;

  @override
  Widget build(context) {
    return CustomPaint(
      painter: Painter(strokeWidth, data),
      size: Size.square(radius),
      child: SizedBox.square(
        // calc diameter
        dimension: radius * 2,
        child: Center(
          child: child,
        ),
      ),
    );
  }
}