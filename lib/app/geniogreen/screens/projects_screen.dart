import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/geniogreen/screens/project_forest_conservation.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProjectsScreen()),
    );
  }

  Widget _buildContainer({
    required Color color,
    required String asset,
    required TextTheme textTheme,
    VoidCallback? onTap,
    required String title,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 16),
          width: 192,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            Image.asset(
              asset,
              height: 115,
            ),
            const Gap(5),
            Row(
              children: [
                const Icon(
                  Icons.eco,
                  color: Colors.white,
                ),
                Text(
                  '500',
                  style: textTheme.headlineMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
            const Gap(5),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(color: Colors.white),
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.greenbg,
        title: Text(
          'Project',
          style: textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: 260,
          decoration: const BoxDecoration(
              color: AppColor.greenbg,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              )),
          child: Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(32),
                    Text(
                      'Choose your project',
                      style: textTheme.displaySmall?.copyWith(color: Colors.white),
                    ),
                    Text(
                      "Let's burn some carbon",
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                  ])),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 130, left: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 240,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                _buildContainer(
                    color: AppColor.paleGreen,
                    asset: 'assets/images/geniogreen_elephant.png',
                    onTap: () {
                      ProjectForestConservation.show(context);
                    },
                    textTheme: textTheme,
                    title: 'Forest Conservation in Kenya'),
                _buildContainer(
                    color: AppColor.darkGreen,
                    asset: 'assets/images/geniogreen_wind_energy.png',
                    textTheme: textTheme,
                    title: 'Wind energy in the Carribean'),
                _buildContainer(
                    color: AppColor.darkGreen,
                    asset: 'assets/images/geniogreen_clean_water.png',
                    title: 'Clean water for Madagascar',
                    textTheme: textTheme)
              ]),
            ),
            const Gap(32),
            Text(
              'Wind energy on Aruba, the Caribbean',
              style: textTheme.headlineMedium?.copyWith(color: AppColor.greenbg),
            ),
            const Gap(8),
            const Text(
                "The power supply on the Caribbean island of Aruba is mainly dependent on diesel and other fossil fuels. This has two major disadvantages: firstly, these resources must be imported from abroad, and secondly, they cause significant amounts of greenhouse gas emissions. Our Carbon offset project aims to combat these drawbacks, by using the island's natural energy resource: wind.")
          ]),
        )
      ]),
    );
  }
}
