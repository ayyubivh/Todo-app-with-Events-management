import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/provider/providers.dart';
import 'package:todo_app/widgets/common_widgets/common_text.dart';

String? imagepath;

class EventImage extends StatelessWidget {
  EventImage({super.key, required this.flag});

  var flag;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      height: 130,
      child: Consumer(
        builder: (context, ref, child) {
          final imagewatch = ref.watch(imagaProvider);
          return GestureDetector(
            child: imagewatch == ''
                ? chooseImage(flag, imagepath)
                : Image.file(File(imagewatch)),
            onTap: () async {
              final imagewatch = await takePhoto();
              ref.read(imagaProvider.notifier).state = imagewatch;
              imagepath = imagewatch;
            },
          );
        },
      ),
    );
  }
}

Future<String> takePhoto() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage == null) {
    return '';
  } else {
    return pickedImage.path;
  }
}

Image chooseImage(flag, path) {
  if (flag == false) {
    return Image.asset('Asset/images/event.jpg');
  } else {
    return Image.asset('Asset/images/event.jpg');
  }
}
