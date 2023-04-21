import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geniuspay/app/jar/pages/set_goal_screen.dart';
import 'package:geniuspay/app/jar/widgets/jar_app_bar.dart';
import 'package:geniuspay/app/shared_widgets/size_config.dart';
import 'package:geniuspay/util/color_scheme.dart';

import 'package:geniuspay/app/jar/widgets/assets.gen.dart';

class NameSelectionScreen extends StatefulWidget {
  const NameSelectionScreen({Key? key}) : super(key: key);

  @override
  State<NameSelectionScreen> createState() => _NameSelectionScreenState();
}

class _NameSelectionScreenState extends State<NameSelectionScreen> {
  final TextEditingController nameController = TextEditingController();
  Uint8List? selectedImage;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const JarAppBar(
        backgroundColor: Colors.transparent,
        text: 'Jar',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22.5, right: 22.5),
        child: ListView(
          children: [
            const Gap(100),
            SizedBox(
              height: 140,
              width: 140,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Assets.backgrounds.arcStyle.image(
                      height: 140,
                      width: 140,
                      color: AppColor.kSecondaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        selectedImage = await image.readAsBytes();
                        setState(() {});
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(selectedImage == null ? 30 : 0),
                        decoration: BoxDecoration(
                            color: AppColor.kAccentColor2,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color(0xff0A6375).withOpacity(0.2),
                                  offset: const Offset(0, 4),
                                  blurRadius: 14,
                                  spreadRadius: 0)
                            ],
                            shape: BoxShape.circle),
                        child: selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SvgPicture.asset('assets/icons/camera.svg',
                                height: 40, width: 40, fit: BoxFit.contain),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Gap(32),
            TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              style: textTheme.displaySmall,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: InputBorder.none,
                hintStyle: textTheme.displaySmall,
              ),
            ),
            const Gap(24),
            CustomElevatedButton(
              onPressed: () {
                if (selectedImage != null) {
                  SetGoalScreen.show(context, {
                    'selectedImage': selectedImage,
                    'name': nameController.text,
                  });
                }
              },
              radius: 8,
              color: selectedImage == null || nameController.text.isEmpty
                  ? AppColor.kAccentColor2
                  : AppColor.kGoldColor2,
              child: Text('CONTINUE',
                  style: selectedImage == null
                      ? textTheme.bodyMedium
                      : textTheme.bodyLarge),
            )
          ],
        ),
      ),
    );
  }
}
