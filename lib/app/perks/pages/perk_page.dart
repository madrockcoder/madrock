import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/perks/pages/perk_detail_page.dart';
import 'package:geniuspay/app/perks/view_models/perk_vm.dart';
import 'package:geniuspay/app/shared_widgets/textfield_decoration.dart';
import 'package:geniuspay/core/view_helper/base_view.dart';
import 'package:geniuspay/core/view_helper/view_model/base_view_model.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:shimmer/shimmer.dart';

class PerkPage extends StatefulWidget {
  const PerkPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PerkPage(),
      ),
    );
  }

  @override
  State<PerkPage> createState() => _PerkPageState();
}

class _PerkPageState extends State<PerkPage> {
  final _searchController = TextEditingController();
  final _searchFocus = FocusNode();
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseView<PerksViewModel>(onModelReady: (p0) async {
      p0.getPerks();
      await p0.getCategories();
      p0.getUser();
    }, builder: (context, model, snapshot) {
      return Scaffold(
        appBar: WidgetsUtil.onBoardingAppBar(
          context,
          title: 'Perks',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: AppColor.kAccentColor2,
                        border: Border.all(color: AppColor.kSecondaryColor)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15, left: 21),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/yellow_star.svg',
                            width: 35,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Points',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                model.points,
                                style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.kSecondaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  height: 32,
                  child: model.categoriesState == BaseModelState.loading
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 6,
                              itemBuilder: (_, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: AppColor.kGoldColor2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0,
                                          right: 14,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        'Travel',
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                );
                              }))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.categories.length,
                          itemBuilder: (_, i) {
                            return InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  setState(() {
                                    selectedCategory = i;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: i == selectedCategory
                                          ? AppColor.kAccentColor2
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: i == selectedCategory
                                              ? AppColor.kAccentColor2
                                              : AppColor.kGoldColor2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 14.0,
                                          right: 14,
                                          top: 4,
                                          bottom: 4),
                                      child: Text(
                                        model.categories[i],
                                        style: textTheme.bodyMedium?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: TextFieldDecoration(
                          focusNode: _searchFocus,
                          context: context,
                          hintText: 'Search',
                          clearSize: 8,
                          prefix: const Icon(
                            CupertinoIcons.search,
                            color: AppColor.kSecondaryColor,
                            size: 18,
                          ),
                          onClearTap: () {},
                          controller: _searchController,
                        ).inputDecoration(),
                        focusNode: _searchFocus,
                        keyboardType: TextInputType.name,
                        onTap: () {
                          setState(() {});
                        },
                        onChanged: (val) {
                          setState(() {});
                        },
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!(selectedCategory == 0
                    ? model.perksList.isEmpty
                    : (model.perksList
                        .where((element) =>
                            element.category ==
                            model.categories[selectedCategory])
                        .isEmpty)))
                  Padding(
                    padding: const EdgeInsets.only(left: 23.0, right: 18),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: selectedCategory == 0
                                ? model.perksList.length.toString()
                                : (model.perksList
                                        .where((element) =>
                                            element.category ==
                                            model.categories[selectedCategory])
                                        .length)
                                    .toString(),
                            style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.black),
                            children: const [
                              TextSpan(
                                  text: ' offers',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 12,
                ),
                if (model.pointsListState == BaseModelState.loading)
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                          itemCount: 7,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return ListTile(
                              minVerticalPadding: 12,
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(1000),
                                    image: const DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/emirates_logo.png'))),
                              ),
                              title: Text(
                                'Emirates',
                                style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                '10% discount on your next flight',
                                style: textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kGreyColor, fontSize: 10),
                              ),
                              trailing: Text(
                                '40 points',
                                style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.kSecondaryColor),
                              ),
                            );
                          }))
                else if ((selectedCategory == 0 && model.perksList.isEmpty) ||
                    (selectedCategory != 0 &&
                        (model.perksList
                                .where((element) =>
                                    element.category ==
                                    model.categories[selectedCategory])
                                .length) ==
                            0))
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/perks_empty.png',
                        width: 200,
                      ),
                      const Gap(16),
                      const Text('Perks will be available soon.')
                    ],
                  )
                else
                  ListView.builder(
                      itemCount: model.perksList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        if (selectedCategory == 0 ||
                            model.categories[selectedCategory] ==
                                model.perksList[i].category) {
                          return ListTile(
                            minVerticalPadding: 12,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PerkDetailPage(
                                    perk: model.perksList[i],
                                    user: model.authenticationService.user!,
                                  ),
                                ),
                              );
                            },
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(1000),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          model.perksList[i].company.logo))),
                            ),
                            title: Text(
                              model.perksList[i].company.name,
                              style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              model.perksList[i].name,
                              style: textTheme.bodyMedium?.copyWith(
                                  color: AppColor.kGreyColor, fontSize: 10),
                            ),
                            trailing: Text(
                              "${model.perksList[i].points} points",
                              style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.kSecondaryColor),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
