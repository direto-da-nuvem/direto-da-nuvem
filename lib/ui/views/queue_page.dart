import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/controllers/login_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../routes/app_pages.dart';
import 'package:flutter/material.dart';

Future<void> goBack() async{
  //go back
    queueLoaded = false;
    Get.offAndToNamed(Routes.DASHBOARD);
}

final storage = FirebaseStorage.instance;
bool queueLoaded = false;

class Queue {
  String name;
  String id;
  String device;
  String adminEmail;

  Queue({required this.name, required this.id, required this.device, required this.adminEmail});

  String toString(){
    String ans = name + ";" + id+";" +name.removeAllWhitespace + ';'+device+';'+adminEmail+'*';
    return ans;
  }

}

class QueueListPage extends StatefulWidget {
  const QueueListPage({Key? key}) : super(key: key);

  @override
  _QueueListPageState createState() => _QueueListPageState();
}


class _QueueListPageState extends State<QueueListPage> {
  Queue queueFromString(String qsplit){
    List<String> qparts = qsplit.split(';');
    print(qparts);
    print(qparts[0]);
    print(qparts[1]);
    print(qparts[2]);
    print(qparts[3]);
    return Queue(name: qparts[0], id:qparts[1], device: qparts[2], adminEmail: qparts[3]);
  }

  List<Queue> queuesFromString(String qstring){
    List<Queue> queues = <Queue>[];
    List<String> qsplits = qstring.split('*');
    qsplits.forEach((element) {
      print(element);
      if(element.removeAllWhitespace != ''){
      queues.add(queueFromString(element));}
    });
    return queues;
  }
  List<Queue> queues = <Queue>[];

  String ogstring = "Queue 1;Queue1;TestDevice #1;gpaes@id.uff.br, admin1@gmail.com*Queue 2;Queue2;TestDevice #2;gpaes@id.uff.br*";

  void getQueueData() async{
    dynamic requests = await storage.ref().child("queue_data.txt").getData();
    queues = queuesFromString(utf8.decode(requests));
    queueLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('m ' + queueLoaded.toString());
    if(!queueLoaded){
      getQueueData();
    }
    return queueLoaded? Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(toolbarHeight: 50, title: Text("Manage Queues"), centerTitle: false,leading: IconButton(onPressed: ()=> goBack(), icon: Icon(Icons.arrow_back)),),

      body: ListView.builder(
        itemCount: queues.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0), // Add margin for spacing
                child: ListTile(
                  title: Text(queues[index].name),
                  subtitle: Text('Device: ${queues[index].device}\nAdmins: ${queues[index].adminEmail}'),
                  onTap: () {
                    // Navigate to a page where the user can edit the selected queue
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QueueEditPage(queue: queues[index]),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.5),
                child: Container(width:400,child: Divider(height: 1.0, thickness: 1.0)),
              ), // Add a line between tiles

            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a page where the user can create a new queue
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QueueCreatePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    ) : Scaffold(
        appBar: AppBar(toolbarHeight: 50, title: Text("Manage Queues"), centerTitle: false,leading: IconButton(onPressed: ()=> goBack(), icon: Icon(Icons.arrow_back)),),
        body: Center(child: CircularProgressIndicator()));
  }
}

class QueueEditPage extends StatefulWidget {
  final Queue queue;

  QueueEditPage({required this.queue});

  @override
  _QueueEditPageState createState() => _QueueEditPageState();
}

void setNewDevice(String device, String queueName){
  String newQDfile = '';
  newQDfile = 'No Device;Queue2*';
  newQDfile += device + ';' + queueName + '*';
  storage.ref().child("queue_devices.txt").putString(newQDfile);
}

class _QueueEditPageState extends State<QueueEditPage> {
  late TextEditingController nameController;
  late TextEditingController deviceController;
  late TextEditingController adminEmailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.queue.name);
    deviceController = TextEditingController(text: widget.queue.device);
    adminEmailController = TextEditingController(text: widget.queue.adminEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: Text('Edit Queue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: deviceController,
              decoration: InputDecoration(labelText: 'Device'),
            ),
            TextField(
              controller: adminEmailController,
              decoration: InputDecoration(labelText: 'Admin Emails'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Save the changes and pop the page
                    widget.queue.name = nameController.text;
                    widget.queue.device = deviceController.text;
                    widget.queue.adminEmail = adminEmailController.text;
                    setNewDevice(widget.queue.device,widget.queue.name);
                    Navigator.pop(context);
                  },
                  child: Text('Save Changes'),
                ),
                SizedBox(width: 12,),
                ElevatedButton(
                  onPressed: () {
                    // Save the changes and pop the page
                    queueLoaded = false;
                    Get.offAndToNamed(Routes.EDIT,arguments: [widget.queue.id,false]);
                  },
                  child: Text('Edit Queue Images'),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QueueCreatePage extends StatefulWidget {
  @override
  _QueueCreatePageState createState() => _QueueCreatePageState();
}

class _QueueCreatePageState extends State<QueueCreatePage> {
  late TextEditingController nameController;
  late TextEditingController deviceController;
  late TextEditingController adminEmailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    deviceController = TextEditingController();
    adminEmailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      appBar: AppBar(
        title: Text('Create Queue'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: deviceController,
              decoration: InputDecoration(labelText: 'Device'),
            ),
            TextField(
              controller: adminEmailController,
              decoration: InputDecoration(labelText: 'Admin Emails'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a new queue and add it to the list
                Queue newQueue = Queue(
                  name: nameController.text,
                  id: nameController.text.removeAllWhitespace,
                  device: deviceController.text,
                  adminEmail: adminEmailController.text,
                );
                Navigator.pop(context, newQueue);
              },
              child: Text('Create Queue'),
            ),
          ],
        ),
      ),
    );
  }
}
