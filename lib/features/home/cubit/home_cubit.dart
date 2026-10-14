import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/home_services.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/services/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeServices homeServices;
  HomeCubit(this.homeServices) : super(HomeInitial());

  void loadHomeData() async{
    try{
      final categories =  await homeServices.getCategories();
      emit(CategoriesSuccess(categories));
      final products = await homeServices.getProducts(categories[0].id);
      emit(ProductsSuccess(products));
    } catch(e){
      emit(CategoriesError(e.toString()));
    }
  }
}
