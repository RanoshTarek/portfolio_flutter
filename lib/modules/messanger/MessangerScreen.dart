import 'package:first_app/model/user/chat/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  List<UserModule> users = [
    new UserModule("rana", "rana message"),
    new UserModule("rana", "rana message"),
    new UserModule("radsna", "sdfsd message"),
    new UserModule("rana", "rana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "dsas message"),
    new UserModule("rasdsna", "rddddana message"),
    new UserModule("rana", "rana message"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 1.0,
            backgroundImage: NetworkImage(
                "https://cdn.shopify.com/s/files/1/0035/2754/0782/articles/International_Flower_Day_1239x.jpeg?v=1579365491"),
          ),
        ),
        title: Text(
          'Chats',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 15.0,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 16.0,
                  )),
              onPressed: () {}),
          IconButton(
              icon: CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 15.0,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16.0,
                  )),
              onPressed: () {})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      labelStyle: TextStyle(fontSize: 18),
                      border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return buildStoryItem();
                  },
                ),
              ),
              SizedBox(height: 20),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildMessageItem(users[index]),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.0,
                ),
                itemCount: users.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/34492145?v=4'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 3.0,
                  end: 3.0,
                ),
                child: CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'hello my name is abdullah ahmed hello my name is abdullah ahmed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: Container(
                        width: 7.0,
                        height: 7.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text(
                      '02:00 pm',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildMessageItem(UserModule User) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    "https://cdn.shopify.com/s/files/1/0035/2754/0782/articles/International_Flower_Day_1239x.jpeg?v=1579365491"),
              ),
              CircleAvatar(
                radius: 5.5,
                backgroundColor: Colors.white,
              ),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    User.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          User.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Text(
                        '02:09 pm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildStoryItem() {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    "https://cdn.shopify.com/s/files/1/0035/2754/0782/articles/International_Flower_Day_1239x.jpeg?v=1579365491"),
              ),
              CircleAvatar(
                radius: 5.5,
                backgroundColor: Colors.white,
              ),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),
            ],
          ),
          Text(
            'Rana Tarek yahia',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }
}
