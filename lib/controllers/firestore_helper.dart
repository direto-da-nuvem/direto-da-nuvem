import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dduff/ui/views/queue_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

 class FirestoreHelper extends GetxController {
    String QID = '';
    
    Future<void> deleteData_deleteDocs() async {
    print(QID);
  
    final reference = FirebaseFirestore.instance.collection("queue").doc();
}
 }

