import 'package:first_online_shopping_app/data/api/api_client.dart';
import 'package:first_online_shopping_app/data/controller/cart_controller.dart';
import 'package:first_online_shopping_app/data/controller/popular_product_controller.dart';
import 'package:first_online_shopping_app/data/controller/recommended_product_controller.dart';
import 'package:first_online_shopping_app/data/repository/cart_repo.dart';
import 'package:first_online_shopping_app/data/repository/popular_product_repo.dart';
import 'package:first_online_shopping_app/data/repository/recommended_product_repo.dart';
import 'package:first_online_shopping_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

//apiclient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
