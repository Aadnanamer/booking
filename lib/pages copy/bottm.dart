import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '/utils/constants.dart';
import '/utils/static_data.dart';
import '/widgets/app_bottom_navigation.dart';
import '/widgets/house_card.dart';

class bottm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavigation(),

    );
  }
}
