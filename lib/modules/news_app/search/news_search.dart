import 'package:first_app/layout/news_layout/cubit/cubit.dart';
import 'package:first_app/layout/news_layout/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSearch extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
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
                      NewsCubit.get(context).getSearchData(value);
                    },
                    validate: (value) {
                      return null;
                    }),
                Expanded(
                    child: newsConsumerBuilder(
                        news: NewsCubit.get(context).searchList,
                        isSearch: true))
              ],
            ),
          ),
        );
      },
    );
  }
}
