import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final List<XFile>? images;
  final ValueChanged<List<XFile>> onImagesChanged;

  const ImagePickerWidget({
    super.key,
    required this.images,
    required this.onImagesChanged,
  });

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null && pickedImages.length <= 5) {
      widget.onImagesChanged(pickedImages);
    } else {
      if (pickedImages != null && pickedImages.length > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Puedes seleccionar hasta 5 imágenes')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _pickImages,
          child: const Text('Seleccionar Imágenes'),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.images!.map((image) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Image.file(
                  File(image.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.images!.remove(image);
                        widget.onImagesChanged(widget.images!);
                      });
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
