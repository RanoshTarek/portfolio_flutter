import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/home_layout/cubit/cubit.dart';
import 'package:first_app/layout/home_layout/cubit/states.dart';
import 'package:first_app/model/home/home_module.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit;
    shopCubit = ShopCubit.get(context);
    shopCubit.getHomeProductData();
    shopCubit.getCategoryData();
    return SingleChildScrollView(
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: shopCubit.homeModule != null,
              builder: (context) {
                return Column(children: [
                  productBanner(shopCubit),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (shopCubit.categoryModel != null) categoryList(shopCubit),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  productGirdList(context, shopCubit),
                ]);
              },
              fallback: (context) {
                return centerProgressBar();
              });
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget productBanner(ShopCubit shopCubit) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 250,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal),
      items: shopCubit.homeModule.data.banners.map((Banner) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.amber),
                child: Image(
                  width: double.infinity,
                  image: NetworkImage(Banner.image),
                  fit: BoxFit.cover,
                ));
          },
        );
      }).toList(),
    );
  }

  Widget categoryList(ShopCubit shopCubit) {
    if (shopCubit.categoryModel.data.data.length > 0) {
      return Container(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    width: 100,
                    image: NetworkImage(
                        shopCubit.categoryModel.data.data[index].image),
                    height: 100,
                  ),
                  Container(
                    color: Colors.white.withOpacity(.8),
                    width: 100.0,
                    padding: EdgeInsets.all(6),
                    child: Text(
                      shopCubit.categoryModel.data.data[index].name,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: shopCubit.categoryModel.data.data.length),
      );
    }
  }

  Widget productGirdList(context, ShopCubit shopCubit) {
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1 / 2,
        children: List.generate(
          shopCubit.homeModule.data.products.length,
          (index) => buildProductItem(shopCubit.homeModule.data.products[index],
              context, index, shopCubit),
        ),
      ),
    );
  }

  Widget buildProductItem(
      Product product, context, index, ShopCubit shopCubit) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  width: double.infinity,
                  image: NetworkImage(product.image),
                  height: 200,
                ),
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
              height: 6,
            ),
            if (product.discount != null)
              Text(
                '${product.name}',
                style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold),
              ),
            Spacer(),
            Row(
              children: [
                Text(
                  '${product.price}',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 6,
                ),
                if (product.discount != null)
                  Text(
                    '${product.old_price}',
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      shopCubit.onFavouriteClick(id: product.id, index: index);
                    },
                    icon: CircleAvatar(
                      radius: 22.0,
                      backgroundColor:
                          product.in_favorites ? primaryColor : Colors.grey,
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
      ),
    );
  }
}
