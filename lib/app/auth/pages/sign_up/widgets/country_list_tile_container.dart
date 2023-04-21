import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/country_flag_container.dart';
import 'package:geniuspay/models/country.dart';
import 'package:geniuspay/util/color_scheme.dart';

class CountryListTileContainer extends StatefulWidget {
  const CountryListTileContainer(
      {Key? key, required this.countries, required this.onTap, this.selected})
      : super(key: key);
  final List<Country> countries;
  final Function(Country) onTap;
  final Country? selected;

  @override
  State<CountryListTileContainer> createState() =>
      _CountryListTileContainerState();
}

class _CountryListTileContainerState extends State<CountryListTileContainer> {
  // final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var country in widget.countries)
          InkWell(
            onTap: () {
              widget.onTap(country);
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
              setState(() {});
            },
            child: ListTile(
              dense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              title: Text(
                country.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.kOnPrimaryTextColor3,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
              trailing: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.selected != null &&
                          widget.selected!.iso2 == country.iso2
                      ? AppColor.kSecondaryColor
                      : Colors.transparent,
                  border: Border.all(color: AppColor.kSecondaryColor),
                ),
                child: widget.selected != null &&
                        widget.selected!.iso2 == country.iso2
                    ? const Center(
                        child: Icon(
                          Icons.done,
                          size: 12,
                          color: Colors.white,
                        ),
                      )
                    : const SizedBox(),
              ),
              leading: SizedBox(
                width: 40.0,
                child: Row(
                  children: [
                    CountryFlagContainer(flag: country.iso2),
                    // const SizedBox(width: 16.0),
                    // Text(
                    //   country.iso2,
                    //   //
                    //   style: GoogleFonts.lato(
                    //     textStyle: Theme.of(context)
                    //         .textTheme
                    //         .headline5
                    //         ?.copyWith(
                    //             color: AppColor.kPinDesColor,
                    //             fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
