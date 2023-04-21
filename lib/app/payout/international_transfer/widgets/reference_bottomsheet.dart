import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/assign_category_bottomsheet.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/category.dart';
import 'package:geniuspay/app/payout/international_transfer/widgets/reference.dart';
import 'package:geniuspay/app/shared_widgets/custom_yellow_elevated_button.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ReferenceBottomSheet extends StatefulWidget {
  final Reference? selectedReference;

  const ReferenceBottomSheet({Key? key, this.selectedReference})
      : super(key: key);

  @override
  State<ReferenceBottomSheet> createState() => _ReferenceBottomSheetState();
}

class _ReferenceBottomSheetState extends State<ReferenceBottomSheet> {
  late TextEditingController controller;
  final messageFocus = FocusNode();
  late Reference selectedReference;

  @override
  void initState() {
    selectedReference =
        widget.selectedReference ?? Reference(categoryIcons.first, "");
    controller = TextEditingController(text: widget.selectedReference?.message);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(76),
              const Text(
                "Enter your message",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const Gap(24),
              SizedBox(
                  height: 82,
                  child: TextFormField(
                    controller: controller,
                    onChanged: (val) {
                      _formKey.currentState?.validate();
                      setState(() {});
                    },
                    focusNode: messageFocus,
                    inputFormatters: [LengthLimitingTextInputFormatter(75)],
                    maxLength: 75,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Message can't be empty";
                      } else if (val.length < 2) {
                        return "Minimum 2 characters required";
                      } else if (val.length > 75) {
                        return "Maximum 75 characters";
                      }
                      return null;
                    },
                    decoration: TextFieldDecoration(
                      focusNode: messageFocus,
                      removeClear: true,
                      hintText: 'Enter a message',
                      prefix: InkWell(
                          onTap: () async {
                            Category? _category = await showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return const AssignCategoryBottomSheet();
                                });
                            if (_category != null) {
                              setState(() {
                                selectedReference.category = _category;
                              });
                            }
                          },
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            const Gap(16),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColor.kAccentColor2,
                              child: selectedReference.category.getIcon(16),
                            ),
                            const Gap(4),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColor.kSecondaryColor,
                              size: 16,
                            ),
                            const Gap(8),
                          ])),
                      context: context,
                      onClearTap: () {
                        setState(() {
                          controller.clear();
                        });
                        messageFocus.requestFocus();
                      },
                      controller: controller,
                    ).inputDecoration(),
                  )),
              const Gap(20),
              CustomYellowElevatedButton(
                  text: "CONFIRM",
                  disable: controller.text.trim().isEmpty,
                  onTap: () {
                    if (_formKey.currentState?.validate() == true) {
                      selectedReference.message = controller.text;
                      Navigator.pop(context, selectedReference);
                    }
                  }),
              const Gap(8),
              CustomYellowElevatedButton(
                  text: "CANCEL",
                  transparentBackground: true,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const Gap(24),
            ],
          ),
        ));
  }
}
