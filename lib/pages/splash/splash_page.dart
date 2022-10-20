import 'dart:async';

import 'package:first_online_shopping_app/data/controller/popular_product_controller.dart';
import 'package:first_online_shopping_app/data/controller/recommended_product_controller.dart';
import 'package:first_online_shopping_app/routes/route_helper.dart';
import 'package:first_online_shopping_app/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<PopularProductController>().getPopularProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/images/flower7.jfif',
                width: Dimensions.splashImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
