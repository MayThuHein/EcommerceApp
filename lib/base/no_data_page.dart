import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String text;
  final String imagePath;
  const NoDataPage(
      {super.key,
      required this.text,
      this.imagePath = "assets/images/empty_cart.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imagePath,
          height: 150,
        ),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01,
        // ),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.0175,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
