import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/cubit/cubit.dart';
import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  ShopCubit shopCubit;

  @override
  Widget build(BuildContext context) {
    shopCubit = ShopCubit.get(context);
    shopCubit.getCategoryData();
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is ShopGetCategorySuccessfulState,
            builder: (context) {
              return Container(
                child: categoryList(),
              );
            },
            fallback: (context) {
              return centerProgressBar();
            });
      },
      listener: (context, state) {},
    );
  }

  Widget categoryList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  width: 100,
                  image: NetworkImage(
                      shopCubit.categoryModel.data.data[index].image),
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                child: Text(
                  shopCubit.categoryModel.data.data[index].name,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_rounded),
                color: Colors.grey,
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return separatorBuilder();
        },
        itemCount: shopCubit.categoryModel.data.data.length);
  }
}
