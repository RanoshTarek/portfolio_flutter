import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/cubit/cubit.dart';
import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/model/favourite/FavouriteListModel.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.get(context);
    shopCubit.getFavouriteListResponse();
    //return buildProductItem();
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: shopCubit.favouriteListResponse != null,
            builder: (context) {
              return Container(
                child: productList(
                    shopCubit.favouriteListResponse.data.data, shopCubit),
              );
            },
            fallback: (context) {
              return centerProgressBar();
            });
      },
      listener: (context, state) {},
    );
  }

//
  Widget buildProductItem(List<DataX> data, index, ShopCubit shopCubit) {
    return Container(
      height: 150.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  width: 150,
                  image: NetworkImage(data[index].product.image != null
                      ? data[index].product.image
                      : ''),
                  height: 200,
                ),
                if (data[index].product.discount != null)
                  Container(
                    padding: EdgeInsets.all(6),
                    color: Colors.red,
                    child: Text(
                      "Discount",
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 6,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${(data[index].product.name)}',
                    style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${(data[index].product.price)}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      if (data[index].product.discount != null)
                        Text(
                          '${(data[index].product.old_price)}',
                          style: TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            shopCubit.onFavouriteClick(
                                id: data[index].product.id,
                                index: index,
                                isFromFavouriteScreen: true);
                          },
                          icon: CircleAvatar(
                            radius: 22.0,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.favorite_border,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productList(List<DataX> data, ShopCubit shopCubit) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return buildProductItem(data, index, shopCubit);
        },
        separatorBuilder: (context, index) {
          return separatorBuilder();
        },
        itemCount: data.length);
  }
}
