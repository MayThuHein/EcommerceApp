import 'package:first_online_shopping_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        style: TextStyle(
            fontFamily: 'Roboto',
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: size == 0 ? Dimensions.font18 : size));
  }
}
