import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File?) onPickImage;

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

    widget.onPickImage(_selectedImage);
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
    widget.onPickImage(_selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
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
                Image.asset(
                  'assets/images/img_logo.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  icon: const Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.black,
                  ),
                  onPressed: _takePicture,
                  label: const Text(
                    'Pick your image',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(
                    Icons.browse_gallery_rounded,
                    color: Colors.black,
                  ),
                  onPressed: _takePictureGallery,
                  label: const Text(
                    'Pick image from gallery',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
    );
  }
}
