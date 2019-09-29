import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_qrcode_app/utils/image_picker_handler.dart';
import 'package:transparent_image/transparent_image.dart';


class DocumentFileFormField extends StatefulWidget {
  final Function onChanged;
  final Function validator;
  final Function onSaved;
  final File initialImage;

  DocumentFileFormField(
      {this.onChanged, this.validator, this.onSaved, this.initialImage});

  @override
  State<StatefulWidget> createState() {
    return _DocumentFileFormFieldState();
  }
}

class _DocumentFileFormFieldState extends State<DocumentFileFormField>
    with TickerProviderStateMixin, ImagePickerListener {
  File _currentImage;
  ImagePickerHandler _imagePicker;
  bool _initialAssigned = false;

  @override
  userImage(File _image) {
    setState(() {
      this._currentImage = _image;
    });
  }

  @override
  void initState() {
    print("initState of _ProfileFıleFormState");
    _imagePicker = new ImagePickerHandler(this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _addIcon;

    if (!_initialAssigned && widget.initialImage != null && _currentImage == null) {
      _currentImage = widget.initialImage;
      _initialAssigned = true;
    }

    if (_currentImage == null) {
      _addIcon = Icon(
        Icons.add,
        color: Colors.red,
        size: 80,
      );
    } else {
      _addIcon = Stack(
        children: <Widget>[
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: Icon(Icons.edit, color: Colors.red),
          ),
        ],
      );
    }

    return FormField(
      builder: (FormFieldState state) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => _imagePicker.showDialog(context,
                    hasRemoveOption: _currentImage != null),
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 350.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _currentImage == null
                            ? MemoryImage(kTransparentImage)
                            : ExactAssetImage(_currentImage.path),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.black12, width: 1.0),
                      borderRadius: new BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: _addIcon,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onSaved: (e) =>  widget.onSaved != null ? widget.onSaved(_currentImage) : null,
      validator: (e) =>widget.validator != null ? widget.validator(_currentImage) : null,
    );
  }
}
