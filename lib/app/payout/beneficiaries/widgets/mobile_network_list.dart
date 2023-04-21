import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/payout/beneficiaries/view_models/select_mobile_network_vm.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/mobile_network.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:shimmer/shimmer.dart';

class MobileNetworkListWidget extends StatefulWidget {
  final MobileNetwork? selectedMobileNetwork;
  final Function(MobileNetwork mobileNetwork) onTap;
  const MobileNetworkListWidget(
      {Key? key, required this.selectedMobileNetwork, required this.onTap})
      : super(key: key);

  @override
  State<MobileNetworkListWidget> createState() =>
      _MobileNetworkListWidgetState();
}

class _MobileNetworkListWidgetState extends State<MobileNetworkListWidget> {
  final _mobileNetworkController = TextEditingController();
  bool initial = true;

  @override
  void initState() {
    super.initState();
    loadValues();
  }

  loadValues() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        initial = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectMobileNetworkVM>(onModelReady: (p0) async {
      await p0.resetFoundNetworks(context);
    }, builder: (context, model, snapshot) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 26),
          child: Column(
            children: [
              CustomTextField(
                radius: 9,
                validationColor: AppColor.kSecondaryColor,
                controller: _mobileNetworkController,
                fillColor: Colors.transparent,
                keyboardType: TextInputType.name,
                prefixIcon: WidgetsUtil.searchIcon(),
                hasBorder: false,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    model.searchNetwork(keyword: val, context: context);
                  } else if (val.isEmpty) {
                    model.getNetworks(context);
                  }
                },
                hint: 'Select Mobile Network',
              ),
              const Gap(16),
              if (model.searchNetworkBaseModel == BaseModelState.loading)
                Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    enabled: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                  color: AppColor.kSecondaryColor,
                                  shape: BoxShape.circle),
                            ),
                            title: const Text('Mobile Networks'),
                            trailing: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: AppColor.kSecondaryColor,
                                  border: Border.all(
                                      width: 1,
                                      color: AppColor.kSecondaryColor),
                                  shape: BoxShape.circle),
                            ),
                          );
                        })),
              if (model.searchNetworkBaseModel == BaseModelState.success)
                Expanded(
                    child: ListView.builder(
                        itemCount: model.foundNetworks.length > 20
                            ? initial
                                ? 20
                                : model.foundNetworks.length
                            : model.foundNetworks.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              widget.onTap(model.foundNetworks[index]);
                              Navigator.pop(context);
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text(model.foundNetworks[index].networkName),
                            subtitle:
                                Text(model.foundNetworks[index].destination),
                            trailing: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: widget.selectedMobileNetwork?.id ==
                                          model.foundNetworks[index].id
                                      ? AppColor.kSecondaryColor
                                      : AppColor.kWhiteColor,
                                  border: Border.all(
                                      width: 1,
                                      color: AppColor.kSecondaryColor),
                                  shape: BoxShape.circle),
                              child: widget.selectedMobileNetwork?.id ==
                                      model.foundNetworks[index].id
                                  ? const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          );
                        }))
            ],
          ));
    });
  }
}
