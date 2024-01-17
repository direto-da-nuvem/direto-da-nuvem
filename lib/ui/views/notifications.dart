import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';



class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<Map<String, dynamic>> notifications;
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    notifications = [];

    // Fetch notifications from Firestore
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firestore.collection('messages').get();

    setState(() {
      notifications = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> doc) {
        return {
          'id': doc.id,
          'message': doc['message'],
          'read': doc['read'] ?? false,
        };
      })
          .toList();
    });
  }

  Future<void> markAsRead(String id) async {
    await firestore.collection('messages').doc(id).update({'read': true});
    fetchNotifications();
  }

  Future<void> goBack() async{
    Get.offAndToNamed(Routes.DASHBOARD,arguments: Get.arguments[0]);
  }

  Future<void> showNotificationDialog(String message) async {
    String timestamp = "January 17, 2024 at 3:42AM";
    String user = "gpaes@id.uff.br";
        return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
        return AlertDialog(
        title: Text('New update on a Queue you monitor:'
        ''),
        content: Text(message + "\n\n" + "Update happened on " +timestamp+ "." + "\n" + "Update done by " + user + "."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Reverse'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Stop monitoring queue'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text("Queue Updates & Messages"), centerTitle: false,leading: IconButton(onPressed: (){goBack();}, icon: Icon(Icons.arrow_back)),),

      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              notifications[index]['message'],
              style: TextStyle(
                fontWeight: notifications[index]['read']
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
            onTap: () {
              if (!notifications[index]['read']) {
                markAsRead(notifications[index]['id']);
              }
              showNotificationDialog(notifications[index]['message']);
            },
          );
        },
      ),
    );
  }
}

