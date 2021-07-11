import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/cubit/cubit.dart';
import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/model/search/search_module.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  defaultFromField(
                      prefixIcon: Icon(Icons.search),
                      labelText: "search",
                      textInputType: TextInputType.text,
                      controller: searchController,
                      onChange: (value) {
                        searchQuery = value;
                        ShopCubit.get(context).getSearchData(value);
                      },
                      validate: (value) {
                        return null;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ConditionalBuilder(
                          condition: shopCubit.searchList.isNotEmpty,
                          builder: (context) {
                            return Container(
                              child:
                                  productList(shopCubit.searchList, shopCubit),
                            );
                          },
                          fallback: (context) {
                            return centerProgressBar();
                          }))
                ],
              ),
            ),
          );
        });
  }

  Widget buildProductItem(
      List<SearchProduct> data, index, ShopCubit shopCubit) {
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
                  image: NetworkImage(
                      data[index].image != null ? data[index].image : ''),
                  height: 200,
                ),
                // if (data[index].discount != null)
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
                    '${(data[index].name)}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${(data[index].price)}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            shopCubit.onFavouriteClick(
                                id: data[index].id,
                                index: index,
                                isFromSearchScreen: true,
                                searchQuery: searchQuery);
                          },
                          icon: CircleAvatar(
                            radius: 22.0,
                            backgroundColor: data[index].in_favorites
                                ? primaryColor
                                : Colors.grey,
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

  Widget productList(List<SearchProduct> data, ShopCubit shopCubit) {
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
