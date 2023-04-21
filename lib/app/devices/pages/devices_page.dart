import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/app/devices/pages/device_detail_page.dart';
import 'package:geniuspay/app/devices/view_models/devices_vm.dart';
import 'package:geniuspay/app/devices/widgets/devices_loading_widget.dart';
import 'package:geniuspay/app/devices/widgets/devices_widget.dart';
import 'package:geniuspay/app/devices/widgets/empty_devices_widget.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/size_util.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kButton2Color,
      appBar: AppBar(
        backgroundColor: AppColor.kButton2Color,
        elevation: 0,
        leading: Transform.scale(
          scale: 0.35,
          child: SvgPicture.asset(
            'assets/icons/backArrow.svg',
            width: 20,
            height: 20,
          ),
        ),
        title: const Text('Devices'),
        centerTitle: true,
        actions: const [HelpIconButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BaseView<DevicesVM>(
          onModelReady: (p0) => p0.fetchAllDevices(
            context: context,
            searchTerm: '',
            pageNumber: 1,
            pageSize: 10,
          ),
          builder: (context, model, child) {
            if (model.baseModelState == BaseModelState.loading) {
              return const DevicesLoadingWidget(
                number: 10,
              );
            } else if (model.baseModelState == BaseModelState.error) {
              return const EmptyDevicesWidget(
                error: true,
              );
            } else if (model.devicesList.isEmpty) {
              return const EmptyDevicesWidget(
                error: false,
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Currently logged in',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColor.kSecondaryColor, fontSize: 15),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: AppColor.kWhiteColor,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4,
                          color: AppColor.kGrayColor,
                        )
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: model.devicesList.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceDetailPage(
                                appDeviceModel: model.devicesList[index],
                              ),
                            ),
                          ),
                          child: DevicesWidget(
                            appDeviceModel: model.devicesList[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
