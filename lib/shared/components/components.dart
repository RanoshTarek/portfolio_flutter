import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_app/layout/todo_layout/cubit/cubit.dart';
import 'package:first_app/layout/todo_layout/cubit/states.dart';
import 'package:first_app/modules/news_app/web_view/web_view.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFromField(
    {@required TextEditingController controller,
    @required TextInputType textInputType,
    @required Icon prefixIcon,
    Icon suffixIcon,
    Function suffixIconPressed,
    @required Function validate,
    Function onTap,
    Function onChange,
    bool isObscureText: false,
    @required String labelText,
    o}) {
  return TextFormField(
    controller: controller,
    keyboardType: textInputType,
    obscureText: isObscureText,
    validator: validate,
    onTap: onTap,
    onChanged: onChange,
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: (suffixIcon != null)
            ? IconButton(onPressed: suffixIconPressed, icon: suffixIcon)
            : null,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18),
        border: OutlineInputBorder()),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = primaryColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget taskBuilder(Map task, context) {
  TodoCubit appCubit = TodoCubit.get(context);
  return Dismissible(
    key: Key(task['id'].toString()),
    onDismissed: (direction) {
      appCubit.deleteFromDatabase(task['id']);
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 40,
            child: Text("${task['time']}"),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${task['title']}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${task['date']}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        IconButton(
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
            onPressed: () {
              appCubit.updateFromDatabase(TASK_DONE, task['id']);
            }),
        IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              appCubit.updateFromDatabase(TASK_ARCHIVE, task['id']);
            })
      ],
    ),
  );
}

Widget taskConsumerBuilder(List<Map> tasks) {
  return BlocConsumer<TodoCubit, TodoStates>(
    builder: (BuildContext context, state) {
      return ConditionalBuilder(
        condition: tasks.length > 0,
        builder: (BuildContext context) {
          return ListView.separated(
              itemBuilder: (context, index) =>
                  taskBuilder(tasks[index], context),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1,
                );
              },
              itemCount: tasks.length);
        },
        fallback: (context) {
          return Center(
              child: Text(
            "No Tasks Available",
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ));
        },
      );
    },
    listener: (BuildContext context, state) {},
  );
}

Widget newsConsumerBuilder({@required List<dynamic> news, isSearch: false}) {
  return ConditionalBuilder(
    condition: news.length == 0,
    builder: (BuildContext context) {
      return isSearch
          ? Container()
          : Center(child: CircularProgressIndicator());
    },
    fallback: (BuildContext context) => ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigateTo(
                  context: context, widget: WebViewScreen(news[index]['url']));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                news[index]['urlToImage'] != null
                                    ? news[index]['urlToImage']
                                    : ""))),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              news[index]['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(
                            news[index]['publishedAt'],
                            style: TextStyle(
                                color: CupertinoColors.systemGrey2,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return separatorBuilder();
        },
        itemCount: news.length),
  );
}

Widget separatorBuilder() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.grey[300],
      child: SizedBox(
        height: 1,
      ),
    ),
  );
}

void navigateTo({@required context, @required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndRemove({@required context, @required widget}) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

Widget centerProgressBar() => Center(child: CircularProgressIndicator());

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
