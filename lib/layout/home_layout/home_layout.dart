import 'package:first_app/modules/shop_app/shopSearch/search_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var shopCubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              shopCubit.titles[shopCubit.currentIndex],
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context: context, widget: ProductSearchScreen());
                  }),
              IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: () {
                    AppCubit.get(context).changeAppThemeMode();
                  })
            ],
          ),
          body: shopCubit.bottomNavScreen[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            onTap: (index) {
              shopCubit.changeBottomNavIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Product'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
