import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/auth/view_models/select_country_view_model.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/app/shared_widgets/custom_text_field.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:shimmer/shimmer.dart';

class CountryListWidget extends StatefulWidget {
  final Country? selectedCountry;
  final Function(Country country) onTap;
  final bool showPhoneCode;
  final List<String>? allowedCountries;
  const CountryListWidget(
      {Key? key,
      required this.selectedCountry,
      required this.onTap,
      this.allowedCountries,
      this.showPhoneCode = false})
      : super(key: key);

  @override
  State<CountryListWidget> createState() => _CountryListWidgetState();
}

class _CountryListWidgetState extends State<CountryListWidget> {
  final _countryController = TextEditingController();
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
    return BaseView<SelectCountryViewModel>(onModelReady: (p0) async {
      await p0.resetFoundCountries(context);
    }, builder: (context, model, snapshot) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 26),
          child: Column(
            children: [
              CustomTextField(
                radius: 9,
                validationColor: AppColor.kSecondaryColor,
                controller: _countryController,
                fillColor: Colors.transparent,
                keyboardType: TextInputType.name,
                prefixIcon: WidgetsUtil.searchIcon(),
                hasBorder: false,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    model.searchCountry(keyword: val, context: context);
                  } else if (val.isEmpty) {
                    model.getCountries(context);
                  }
                },
                hint: 'Select Country',
              ),
              const Gap(16),
              if (model.searchCountryBaseModel == BaseModelState.loading)
                Expanded(
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
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
                              title: const Text('Country'),
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
                ),
              if (model.searchCountryBaseModel == BaseModelState.success)
                Expanded(
                    child: ListView.builder(
                        itemCount: model.foundCountries.length > 20
                            ? initial
                                ? 20
                                : model.foundCountries.length
                            : model.foundCountries.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (widget.allowedCountries == null ||
                              widget.allowedCountries!
                                  .contains(model.foundCountries[index].iso2)) {
                            return ListTile(
                              onTap: () {
                                widget.onTap(model.foundCountries[index]);
                                Navigator.pop(context);
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: CountryFlagContainer(
                                flag: model.foundCountries[index].iso2,
                                size: 32,
                              ),
                              title: Text(model.foundCountries[index].name),
                              subtitle: widget.showPhoneCode
                                  ? Text(model.foundCountries[index].phoneCode)
                                  : null,
                              trailing: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: widget.selectedCountry?.iso2 ==
                                            model.foundCountries[index].iso2
                                        ? AppColor.kSecondaryColor
                                        : AppColor.kWhiteColor,
                                    border: Border.all(
                                        width: 1,
                                        color: AppColor.kSecondaryColor),
                                    shape: BoxShape.circle),
                                child: widget.selectedCountry?.iso2 ==
                                        model.foundCountries[index].iso2
                                    ? const Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }))
            ],
          ));
    });
  }
}
