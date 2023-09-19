




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/app_style.dart';



// class StepProgressView extends StatelessWidget {
//   final double _width;
//   final List<String> _titles;
//   final int _curStep;
//   final Color _activeColor;
//   final Color _inactiveColor = Colors.white.withOpacity(.4);
//   final double lineWidth = 3.0;
//
//   StepProgressView({
//     Key? key,
//     required int curStep,
//     List<String>? titles,
//     required double width,
//     required Color color,
//   })  : _titles = titles!,
//         _curStep = curStep,
//         _width = width,
//         _activeColor = color,
//         assert(width > 0),
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: _width,
//       child: Column(
//         children: <Widget>[
//           Column(
//             children: _iconViews(),
//           ),
//           SizedBox(height: 8),
//           Column(
//             children: _titleViews(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _iconViews() {
//     var list = <Widget>[];
//     _titles.asMap().forEach((i, icon) {
//       var circleColor = (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
//       var lineColor = _curStep > i + 1 ? _activeColor : _inactiveColor;
//       var iconColor = (i == 0 || _curStep > i + 1) ? _activeColor : _inactiveColor;
//
//       list.add(
//         Container(
//           width: 25.0,
//           height: 25.0,
//           padding: EdgeInsets.all(0),
//           decoration: BoxDecoration(
//             color: lineColor,
//             borderRadius: BorderRadius.all(Radius.circular(22.0)),
//             border: Border.all(
//               color: circleColor,
//               width: 2.0,
//             ),
//           ),
//           child: Icon(
//             Icons.circle,
//             color: iconColor,
//             size: 12.0,
//           ),
//         ),
//       );
//
//       // line between icons
//       if (i != _titles.length - 1) {
//         list.add(
//           Container(
//             height: lineWidth,
//             color: lineColor,
//           ),
//         );
//       }
//     });
//
//     return list;
//   }
//
//   List<Widget> _titleViews() {
//     var list = <Widget>[];
//     _titles.asMap().forEach((i, text) {
//       list.add(Text(text, style: TextStyle(color: Colors.white)));
//     });
//     return list;
//   }
// }