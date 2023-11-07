import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sample/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);


  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


  final List<Image> imageAssets = <Image>[];
  Future<void> beginUpload()
  async {
    await saveToDatabase();
    final picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        setState(() {
          isLoading = true;
        });
        //Writes to 'AllFiles.txt' text file for now, which is a file that contains all images in the database storage
        String allImages = '';
        for(int i =0; i<myTiles.length;i++)
        {
            allImages += myTiles[i] + '\n';
        }
        allImages += (pickedFile.name + '\n');
        print(allImages);
        await storage.ref().child("allImages.txt").putString(allImages);
        await storage.ref().child(pickedFile.name).putFile(File(pickedFile.path));
        isLoading = false;

      }
    gotImages=false;

    Get.offAndToNamed(Routes.EDIT);
  }

  void changeImage(String path){}

  Widget showQueueImages(){
    return const Column(children: []);
  }

  Future<void> saveToDatabase() async{
    isLoading = true;
    String cacheRequests = '';
    for(int i =0; i<myTiles.length;i++)
    {
    if(present[i]){
    cacheRequests += myTiles[i] + '\n';}
    }
    storage.ref().child("Queue1_Requests.txt").putString(cacheRequests);
    isLoading = false;
}

  Future<void> rewriteDatabase() async{
    isLoading = true;
    String cacheRequests = '';
    for(int i =0; i<myTiles.length;i++)
    {
      if(present[i]){
        cacheRequests += myTiles[i] + '\n';}
    }
    storage.ref().child("allImages.txt").putString(cacheRequests);
    isLoading = false;
  }  //change files that are viewable to user (change allFilex.txt list)

  final storage = FirebaseStorage.instance;
  bool isLoading = true;

  Future<void> goBack() async{
    await saveToDatabase();
    //save changes

    //then go back
    Get.offAndToNamed(Routes.DASHBOARD);
  }

  //note: two lists must have the same size, or code won´t run.
  final List myTiles = ["cat.jpg","lake.jpg","rocket.jpg","castle.png"];
  final List cachedTiles = ["cat.jpg","lake.jpg","rocket.jpg","castle.png","clouds.png"];
  final List present = [true,true,true,true]; //current are default images, to be loaded iff no 'allImages.txt' file is filled
  final List images = [];

  void updateTiles(int oldIndex, int newIndex){

    setState(() {
      if(oldIndex<newIndex){newIndex--;} //adjustment for moving downwards

      //gets tile from old list
      String old = myTiles.removeAt(oldIndex);
      myTiles.insert(newIndex, old);

      bool oldBool = present.removeAt(oldIndex);
      present.insert(newIndex, oldBool);

      Image oldImage = imageAssets.removeAt(oldIndex);
      imageAssets.insert(newIndex, oldImage);
      //then swaps to correct position

    });

  }

  String currentQueueFile = "Queue1_Requests.txt";


  Future<void> getRequestedTiles() async{

    //first, load the images that are in your current queue
    dynamic requests = await storage.ref().child(currentQueueFile).getData();

    String sRequests = utf8.decode(requests);

    List<String> files = sRequests.toString().split('\n');
    if(files.length<1){print('No requests found, selected default images to edit.');}
    else{
      while(myTiles.length!=0){ myTiles.removeLast();present.removeLast();} //clear tiles lsits

      for(int i = 0; i<files.length;i++){
        if(files[i].removeAllWhitespace !='' && files[i] != Null && files[i] != ' ' && files[i] != ''){
          myTiles.add(files[i].replaceAll(" ", "").replaceAll("\n", ""));
          present.add(true); //can be modified later
          //dynamic tileImageData = storage.ref().child(files[i].replaceAll(" ", "").replaceAll("\n", "")).getData();
          //Image tileImage = Image.memory(tileImageData,fit:BoxFit.cover);
          //images.add(tileImage);
        }
      }
      myTiles.forEach((element) {print(element);});
    }

    //then, load the ones that are not in your current queue
    dynamic remainingRequests = await storage.ref().child("allImages.txt").getData();
    String remainingSRequests = utf8.decode(remainingRequests);
    List<String> remaingingFiles = remainingSRequests.toString().split('\n');
    if(remaingingFiles.length<1){}
    else{
      for(int i = 0; i<remaingingFiles.length;i++){
        if(remaingingFiles[i].removeAllWhitespace !='' && remaingingFiles[i] != Null && remaingingFiles[i] != ' ' && remaingingFiles[i] != '' && !myTiles.contains(remaingingFiles[i])){
          myTiles.add(remaingingFiles[i].replaceAll(" ", "").replaceAll("\n", ""));
          present.add(false); //can be modified later
        }
      }
      myTiles.forEach((element) {print(element);});
    }


    //then finally, get the images, where it first try to look for them in the cache, and if it´s not in cache downloads from web
    for(int i = 0; i<myTiles.length;i++) {
      String element = myTiles[i];
      if (cachedTiles.contains(element)) {
        Image i = Image.asset("assets/photos/" + element);
        imageAssets.add(i);
      }
      else {
        dynamic i = await storage.ref().child(element).getData();
        Image im = Image.memory(i, fit: BoxFit.cover);
        imageAssets.add(im);
      }
    };




    isLoading = false;
    setState(() {
    });
    return;
  }

  bool gotImages = false;

  @override
  Widget build(BuildContext context) {

    if(!gotImages){getRequestedTiles();gotImages=true;}
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text("Edit Current Queue"), centerTitle: false,leading: IconButton(onPressed: ()=> goBack(), icon: Icon(Icons.arrow_back)),),
      backgroundColor: Colors.white,
      body: isLoading? const Center(child:CircularProgressIndicator()) : Column(
        children: [
          Expanded(
            child: SizedBox(
              height:200,
              child: ReorderableListView(
                padding: EdgeInsets.all(10),
                children: [for (int i =0; i<myTiles.length;i++)
                  Padding(
                    key: ValueKey(myTiles[i]),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      child: ReorderableDragStartListener(
                        index:i,
                        child: ListTile(
                            leading: imageAssets[i],
                            title:Text(myTiles[i]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,4,0),
                                  child: Text((i+1).toString()),
                                ),
                                Container(width:40,child: IconButton(onPressed: ()=>{}, icon: Icon(Icons.settings))),
                                Container(width:36,child: Checkbox(key: ValueKey(present[i]) ,value: present[i], onChanged: (bool? value) {setState(() {present[i] = !present[i];}); },)),
                              ],
                            )
                            ),
                      ),
                    ),
                  )
                ],
                onReorder: (oldIndex, newIndex) => updateTiles(oldIndex, newIndex),
              ),
            ),
          ), //list
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(onPressed: ()=>beginUpload(), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text("Add new Image"),
                ],
              ),style:ElevatedButton.styleFrom(primary: Colors.blueGrey)),
            ),
          ) //button
        ],
      )

    );
  }
}



