import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_services.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  final HomeServices homeServices;

  HomeCubit(this.homeServices) : super(HomeInitial());

  List<CategoryModel> categoriesData = [];
  List<ProductModel> productsData = [];

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());

    try {
      categoriesData = await homeServices.getCategories();
      emit(CategoriesSuccess(categoriesData));

      if (categoriesData.isNotEmpty) {
        await getCategoryProducts(categoriesData.first.id!);
      }
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> getCategoryProducts(int categoryId) async {
    emit(ProductsLoading());

    try {
      productsData = await homeServices.getProducts(categoryId);
      emit(ProductsSuccess(productsData));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}

