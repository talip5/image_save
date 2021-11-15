import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title1='Image Save';
  final ImagePicker _picker = ImagePicker();
  var _image;
  List contents=[];
  int no=1;

  Future imageDir() async{
    //Directory tempDir = await getTemporaryDirectory();
    //Directory tempDir = await getApplicationDocumentsDirectory();
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;
    print(tempPath);
  }

  Future imageList() async{
    //Directory tempDir = await getTemporaryDirectory();
    //Directory tempDir = await getApplicationDocumentsDirectory();
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;
    contents=tempDir.listSync();
    final File firstFile=contents[1];
    print(firstFile);
    //final File firstFileRename=firstFile.renameSync('$tempPath/deneme1.jpg');
    //final File firstFileRename=firstFile.renameSync('$tempPath/deneme2.jpg');
    contents.removeAt(2);
    contents.forEach((element) {
      if(element is File){
        print('$no  $element');
        no++;
      }
    });
    print(tempPath);
    print(contents.length);
  }

  Future galery() async{
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    File _imageFile = File(image!.path);
    //final fileName=p.basename(_imageFile.path);
    final fileName=p.basename(_imageFile.path);
    title1=_imageFile.toString();
    //final File localImage=await _imageFile.copy('$tempPath/$fileName');
    final File localImageRename=await _imageFile.copy('$tempPath/$fileName');
      print(_imageFile);
      print(fileName);

  }

  Future camare() async{
       // Capture a photo
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    setState(() {
      _image = File(image!.path);
      title1=_image.toString();
      print(_image);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'image save',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title1),
        ),
        body: Center(
          child: Column(
            children: [
              Text(title1),
              ElevatedButton(
                  onPressed: (){
                    imageDir();
                    print('Image Dir');
                  },
                  child:Text('Image Save')
              ),
              ElevatedButton(
                  onPressed: (){
                    galery();
                    print('Image Galery');
                  },
                  child:Text('Image Galery')),
              ElevatedButton(
                  onPressed: (){
                    camare();
                    print('Image Camare');
                  },
                  child:Text('Image Camare')),
            ],
          ),
        ),
      ),
    );
  }
}
