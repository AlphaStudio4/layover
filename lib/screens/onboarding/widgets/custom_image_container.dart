import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/respositories/storage/storage_repository.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController? tabController;
  const CustomImageContainer({Key? key, this.tabController, this.imageUrl})
      : super(key: key);
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 10.0, right: 10.0),
      child: Column(
        children: [
          Container(
            height: (Get.context!.height / (Get.context!.height / 150)),
            width: (Get.context!.width / (Get.context!.width / 100)),
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border(
                  bottom: BorderSide(color: theme().primaryColor, width: 1),
                  top: BorderSide(color: theme().primaryColor, width: 1),
                  right: BorderSide(color: theme().primaryColor, width: 1),
                  left: BorderSide(color: theme().primaryColor, width: 1)),
            ),
            child: (imageUrl == null)
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.add_circle),
                      color: theme().secondaryHeaderColor,
                      onPressed: () async {
                        print('clicked');
                        ImagePicker picker = ImagePicker();
                        final XFile? _image =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (_image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No image was selected.')));
                        }
                        if (_image != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Uploading...')));
                          context
                              .read<OnboardingBloc>()
                              .add(UpdateUserImages(image: _image));
                        }
                      },
                    ),
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }
}
