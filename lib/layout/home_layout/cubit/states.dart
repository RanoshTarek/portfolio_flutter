import 'package:first_app/model/category/category.dart';
import 'package:first_app/model/favourite/FavouriteListModel.dart';
import 'package:first_app/model/favourite/favourite.dart';
import 'package:first_app/model/home/home_module.dart';
import 'package:first_app/model/user/shop/user_data.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class BottomNavIndexState extends ShopStates {}

class BottomNavScreenState extends ShopStates {}

class ShopGetProductLoadingState extends ShopStates {}

class ShopGetProductSuccessfulState extends ShopStates {
  final HomeModule homeModule;

  ShopGetProductSuccessfulState(this.homeModule);
}

class ShopGetProductErrorState extends ShopStates {
  final String error;

  ShopGetProductErrorState(this.error);
}

class ShopGetCategoryLoadingState extends ShopStates {}

class ShopGetCategorySuccessfulState extends ShopStates {
  final CategoryModel categoryModel;

  ShopGetCategorySuccessfulState(this.categoryModel);
}

class ShopGetCategoryErrorState extends ShopStates {
  final String error;

  ShopGetCategoryErrorState(this.error);
}

class ShopGetFavouriteListLoadingState extends ShopStates {}

class ShopGetFavouriteSuccessfulState extends ShopStates {
  final FavouriteListResponse favouriteListResponse;

  ShopGetFavouriteSuccessfulState(this.favouriteListResponse);
}

class ShopGetFavouriteErrorState extends ShopStates {
  final String error;

  ShopGetFavouriteErrorState(this.error);
}

class ShopChangeFavouriteStatusLoadingState extends ShopStates {}

class ShopFavouriteChangedSuccessfulState extends ShopStates {
  final FavouriteModule favouriteModule;

  ShopFavouriteChangedSuccessfulState(this.favouriteModule);
}

class ShopFavouriteChangedErrorState extends ShopStates {
  final String error;

  ShopFavouriteChangedErrorState(this.error);
}

class ShopGetSearchLoadingState extends ShopStates {}

class ShopGetSearchSuccessfulState extends ShopStates {}

class ShopGetSearchErrorState extends ShopStates {
  final String error;

  ShopGetSearchErrorState(this.error);
}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopGetUserDataSuccessfulState extends ShopStates {
  final UserResponse userResponse;

  ShopGetUserDataSuccessfulState(this.userResponse);
}

class ShopUserDataErrorState extends ShopStates {
  final String error;

  ShopUserDataErrorState(this.error);
}

class UpdateLoadingState extends ShopStates {}

class UpdateSuccessfulState extends ShopStates {}

class UpdateErrorState extends ShopStates {
  final String error;
  UpdateErrorState(this.error);
}
