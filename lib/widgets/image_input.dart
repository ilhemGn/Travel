import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (takenImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(takenImage
          .path); // path to navigate to where it was stored in the device
    });
  }

  void _takePictureGallery() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (takenImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(takenImage
          .path); // path to navigate to where it was stored in the device
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 237, 236, 236),
      ),
      child: _selectedImage != null
          ? GestureDetector(
              onTap: _takePicture,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    ),
                  )),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.camera_enhance_rounded),
                  onPressed: _takePicture,
                  label: const Text('Pick your image'),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.browse_gallery_rounded),
                  onPressed: _takePictureGallery,
                  label: const Text('Pick image from gallery'),
                ),
              ],
            ),
    );
  }
}
