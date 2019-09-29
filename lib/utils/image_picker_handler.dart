import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_qrcode_app/utils/dialogs.dart';


class ImagePickerHandler {
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener);

  removeImage() async {
    _listener.userImage(null);
  }

  openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    cropImage(image);
  }

  openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    cropImage(image);
  }

  Future cropImage(File image) async {
    File croppedFile;
    if (image.path != null) {
       croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: 512,
        maxHeight: 512,
      );
    } else {
      croppedFile = image;
    }
    _listener.userImage(croppedFile);
  }

  showDialog(BuildContext context, {hasRemoveOption = false}) {
    Dialogs.showImagePickerActionSheet(context, this, hasRemoveOption: hasRemoveOption);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}
