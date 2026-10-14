import 'package:ecommerce_app_huma_volve/core/constants/api_endPoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import 'models/category_model.dart';
import 'models/product_model.dart';

class HomeServices {
  final ApiClient apiClient;
  HomeServices(this.apiClient);

  Future<List<CategoryModel>>getCategories() async{
    final res= await apiClient.dio.get(ApiEndpoints.categoriesEndPoint);
    final List data =  res.data;
    final List<CategoryModel> categoriesData =
    data.map((e) => CategoryModel.fromJson(e)).toList();

    return categoriesData;

  }

  Future<List<ProductModel>> getProducts(int? categoryId) async {
    final res = await apiClient.dio.get("${ApiEndpoints.categoriesEndPoint}/$categoryId/${ApiEndpoints.productsEndPoint}");
    final List data = res.data;

    final List<ProductModel> productsData =
    data.map((e) => ProductModel.fromJson(e)).toList();

    return productsData;

  }
}