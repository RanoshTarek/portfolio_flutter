import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/model/category/category.dart';
import 'package:first_app/model/favourite/FavouriteListModel.dart';
import 'package:first_app/model/favourite/favourite.dart';
import 'package:first_app/model/home/home_module.dart';
import 'package:first_app/model/search/search_module.dart';
import 'package:first_app/model/user/shop/user_body_register.dart';
import 'package:first_app/model/user/shop/user_data.dart';
import 'package:first_app/modules/shop_app/category/category_screen.dart';
import 'package:first_app/modules/shop_app/favourite/favourite_screen.dart';
import 'package:first_app/modules/shop_app/product/product_screen.dart';
import 'package:first_app/modules/shop_app/setting/setting.dart';
import 'package:first_app/shared/network/end_points.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    "Product",
    "Category",
    "Favourite",
    "Setting",
  ];
  List<Widget> bottomNavScreen = [
    ProductScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingScreen()
  ];

  void changeBottomNavIndex(index) {
    currentIndex = index;
    emit(BottomNavIndexState());
  }

  HomeModule homeModule;

  void getHomeProductData() {
    emit(ShopGetProductLoadingState());
    DioHelper.getData(url: HOME).then((value) {
      homeModule = HomeModule.fromJson(value.data);
      print('current product : ${value.toString()}');
      emit(ShopGetProductSuccessfulState(homeModule));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(ShopGetProductErrorState(onError.toString()));
    });
  }

  CategoryModel categoryModel;

  void getCategoryData() {
    emit(ShopGetCategoryLoadingState());
    DioHelper.getData(url: CATEGORY).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      print('current Category : ${value.toString()}');
      emit(ShopGetCategorySuccessfulState(categoryModel));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(ShopGetCategoryErrorState(onError.toString()));
    });
  }

  FavouriteListResponse favouriteListResponse;

  void getFavouriteListResponse() {
    emit(ShopGetFavouriteListLoadingState());
    DioHelper.getData(url: FAVOURITE).then((value) {
      favouriteListResponse = FavouriteListResponse.fromJson(value.data);
      print('current FavouriteList : ${value.toString()}');
      emit(ShopGetFavouriteSuccessfulState(favouriteListResponse));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(ShopGetFavouriteErrorState(onError.toString()));
    });
  }

  List<SearchProduct> searchList = List<SearchProduct>();

  void getSearchData(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      emit(ShopGetSearchLoadingState());
      DioHelper.postData(url: PRODUCT_SEARCH, body: {
        'text': searchQuery,
      }).then((value) {
        searchList = SearchModule.fromJson(value.data).data.data;
        print(value);
        emit(ShopGetSearchSuccessfulState());
      }).catchError((onError) {
        print(onError);
        emit(ShopGetSearchErrorState(onError.toString()));
      });
    } else {
      searchList.clear();
      emit(ShopGetSearchSuccessfulState());
    }
  }

  FavouriteModule favouriteModule;

  void onFavouriteClick(
      {@required int id,
      @required int index,
      bool isFromFavouriteScreen = false,
      bool isFromSearchScreen = false,
      String searchQuery}) {
    homeModule.data.products[index].in_favorites =
        !(homeModule.data.products[index].in_favorites);
    DioHelper.postData(url: FAVOURITE, body: {'product_id': id}).then((value) {
      favouriteModule = FavouriteModule.fromJson(value.data);
      homeModule.data.products[index] = homeModule.data.products[index];
      print('current favourite : ${value.toString()}');
      if (!favouriteModule.status) {
        homeModule.data.products[index].in_favorites =
            !(homeModule.data.products[index].in_favorites);
      }
      if (isFromFavouriteScreen) {
        getFavouriteListResponse();
      }
      if (isFromSearchScreen) {
        getSearchData(searchQuery);
      }
      emit(ShopFavouriteChangedSuccessfulState(favouriteModule));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(ShopFavouriteChangedErrorState(onError.toString()));
    });
  }

  UserResponse userModule;

  void getUserDataResponse() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: PROFILE).then((value) {
      userModule = UserResponse.fromJson(value.data);
      print('current UserResponse : ${value.toString()}');
      emit(ShopGetUserDataSuccessfulState(userModule));
    }).catchError((onError) {
      print('Error: ${onError.toString()}');
      emit(ShopUserDataErrorState(onError.toString()));
    });
  }

  void updateUserData(UserBodyUpdate userBody) {
    emit(UpdateLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, body: userBody.toJson())
        .then((value) {
      UserResponse userResponse = UserResponse.fromJson(value.data);
      print("updateUserData ${userResponse.toString()}");
      emit(UpdateSuccessfulState());
    }).catchError((onError) {
      print(onError);
      emit(UpdateErrorState(onError.toString()));
    });
  }
}
