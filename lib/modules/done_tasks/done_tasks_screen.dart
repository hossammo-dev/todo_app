import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoneTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/images/complete.svg',
        width: 300,
        height: 300,
      ),
    );
  }
}
