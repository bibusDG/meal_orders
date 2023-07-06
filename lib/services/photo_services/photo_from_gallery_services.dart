import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PhotoFromGalleryServices{

  takeAPhotoFromGallery() async{

    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (pickedFile != null) {
      final bytes = File(pickedFile.path).readAsBytesSync();
      final picture = base64.encode(bytes);
      return picture;
      // if(photoOf == 'Equipment'){
      //   equipmentController.equipmentByteImage = base64.encode(bytes);
      // }

    }
  }
}