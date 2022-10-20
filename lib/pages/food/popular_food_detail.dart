import 'package:first_online_shopping_app/data/controller/cart_controller.dart';
import 'package:first_online_shopping_app/data/controller/popular_product_controller.dart';
import 'package:first_online_shopping_app/pages/cart/cart_page.dart';
import 'package:first_online_shopping_app/pages/home/main_food_page.dart';
import 'package:first_online_shopping_app/routes/route_helper.dart';
import 'package:first_online_shopping_app/utils/app_constants.dart';
import 'package:first_online_shopping_app/utils/colors.dart';
import 'package:first_online_shopping_app/utils/dimensions.dart';
import 'package:first_online_shopping_app/widgets/app_column.dart';
import 'package:first_online_shopping_app/widgets/app_icon.dart';
import 'package:first_online_shopping_app/widgets/big_text.dart';
import 'package:first_online_shopping_app/widgets/expandable_text_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        //background image
        Container(
          width: double.maxFinite,
          height: Dimensions.popularFoodImgSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            color: Colors.white38,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(AppConstants.BASE_URL +
                  AppConstants.UPLOAD_URL +
                  product.img!),
            ),
          ),
        ),
        //icon widget
        Positioned(
          top: Dimensions.height45,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    if (page == 'cartpage') {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios)),
              GetBuilder<PopularProductController>(builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    if (controller.totalItems >= 1) {
                      Get.toNamed(RouteHelper.getCartPage());
                    }
                  },
                  child: Stack(
                    children: [
                      const AppIcon(icon: Icons.shopping_cart_outlined),
                      controller.totalItems >= 1
                          ? const Positioned(
                              top: 0,
                              right: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      controller.totalItems >= 1
                          ? Positioned(
                              top: 3,
                              right: 3,
                              child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white),
                            )
                          : Container(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        //introduction of food
        Container(
          margin: EdgeInsets.only(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
          ),
          padding: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white,
          ),
          // height: 300,
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppColumn(text: product.name!),
              SizedBox(
                height: Dimensions.height20,
              ),
              BigText(text: "Introduce"),
              SizedBox(
                height: Dimensions.height20,
              ),
              //expandable text widget
              Expanded(
                child: SingleChildScrollView(
                  child: ExpandableTextWidget(
                    text: product.description!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(width: Dimensions.width10 / 2),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.width10 / 2),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: const Icon(Icons.add,
                              color: AppColors.signColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
