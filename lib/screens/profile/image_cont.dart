import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/theme.dart';
import '../../widgets/user_image.dart';

class ImageCont extends StatelessWidget {
  final String? image;
  final String id;
  const ImageCont({Key? key, this.image, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8.0),
        child: UserImage.small(
          width: (MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.width / 100)),
          height: (MediaQuery.of(context).size.height /
              (MediaQuery.of(context).size.height / 250)),
          url: (image != '')
              ? image
              : 'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png',
          border: Border.all(color: theme().secondaryHeaderColor),
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.only(top: 75.0, left: 60),
      //   child: IconButton(
      //     icon: Icon(Icons.camera_alt),
      //     color: Colors.white,
      //     onPressed: () async {
      //       final picker = ImagePicker();
      //       PickedFile image;

      //       final XFile? _image =
      //           await picker.pickImage(source: ImageSource.gallery);
      //       final firebase_storage.FirebaseStorage storage =
      //           firebase_storage.FirebaseStorage.instance;
      //       String imageUrl;
      //       if (_image != null) {
      //         //Upload to Firebase
      //         var snapshot = await storage.ref('${id}/${_image.name}').putFile(
      //               File(_image.path),
      //             );
      //         var downloadUrl = await snapshot.ref.getDownloadURL();
      //         // images[index] = '${downloadUrl}';
      //         print(downloadUrl);
      //         // FirebaseFirestore.instance
      //         //     .collection('users')
      //         //     .doc(state.user.id)
      //         //     .update({
      //         //   'imageUrls': FieldValue.arrayUnion(
      //         //       [downloadUrl]),
      //         // });
      //         ScaffoldMessenger.of(context)
      //             .showSnackBar(const SnackBar(content: Text('Uploading...')));
      //         FirebaseFirestore.instance.collection('users').doc(id).update({
      //           'imageUrls': FieldValue.arrayUnion([downloadUrl])
      //         });
      //         print('object');
      //       }
      //     },
      //   ),
      // )
    ]);
  }
}
