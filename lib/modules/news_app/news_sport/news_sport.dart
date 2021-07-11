import 'package:first_app/layout/news_layout/cubit/cubit.dart';
import 'package:first_app/layout/news_layout/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSport extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        return newsConsumerBuilder(news: NewsCubit.get(context).sports);
      },
    );
  }
}
