import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../config/resources/color_manger.dart';
import '../config/resources/font_manger.dart';
import '../config/resources/style_manger.dart';

class NoUsers extends StatelessWidget {
  final String title;
  const NoUsers({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset('assets/images/empty.svg',height: 300,),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: Text(
    title,
            style: getMyMediumTextStyle(color: ColorManger.grey),
          ),
        )
      ],
    );
  }
}
