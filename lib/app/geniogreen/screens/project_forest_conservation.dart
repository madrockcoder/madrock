import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class ProjectForestConservation extends StatelessWidget {
  const ProjectForestConservation({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProjectForestConservation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColor.paleGreen,
      appBar: AppBar(
        backgroundColor: AppColor.paleGreen,
        title: Text(
          'Project',
          style: textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(children: [
        const Gap(32),
        Image.asset(
          'assets/images/geniogreen_elephant.png',
          height: 120,
        ),
        const Gap(24),
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 44),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.22),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forest conservation, Kasigau Wildlife Corridor, Kenya',
                  style: textTheme.headlineMedium?.copyWith(color: AppColor.greenbg),
                ),
                const Gap(16),
                const Text(
                    "How do you actually conserve 200,000 hectares of forest? The forest in question is a section of dry forest and savanna in the Kasigau Wildlife Corridor, which connects the Tsavo East and Tsavo West Natural Parks in Kenya. It is home to countless endangered species such as lions, elephants and zebras as well as numerous species of birds.\n\n"
                    "However, this forest area is facing massive deforestation and slash-and-burn practices. In order to protect the Kasigau Wildlife Corridor, people from the local population are being trained as rangers to guard and defend the area. More income opportunities for the local population are required in order to reduce the depletion of the natural environment. Hence, this project creates jobs in both small businesses and larger factories."
                    "This project was chosen as the Best Offsetting Project in Environmental Finance's 8th voluntary carbon poll in 2017."),
                const Gap(16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: AppColor.darkGreen),
                  child: Text(
                    '1,000,000\nANNUAL VOLUME (TONS CO2)',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
                const Gap(16),
                Text(
                  'Contribution to the UN sustainable\ndevelopment goals (SDGs)',
                  style: textTheme.headlineMedium?.copyWith(color: AppColor.greenbg),
                ),
                const Gap(8),
                Image.asset('assets/images/geniogreen_un_goals.png'),
                const Gap(24),
                Text(
                  'How does forest protection help fight global warming?',
                  style: textTheme.headlineMedium?.copyWith(color: AppColor.greenbg),
                ),
                const Gap(8),
                const Text(
                    "Forests, especially tropical ones, store CO2. For projects aimed at combatting climate change, there are essentially three methods for creating and sustaining forestry as a carbon sink:\n\n"
                    "• forestation and reforestation\n"
                    "• sustainable forest management (where the amount of timber harvested does not exceed the amount that can grow back)\n"
                    "• financial incentives for the protection of forestland as a carbon sink (the UN's REDD+ program), whereby the project owner must ensure that tree cover is maintained"),
                const Gap(32),
                CustomElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "CONTINUE",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  color: AppColor.greenbg,
                )
              ],
            )),
      ]),
    );
  }
}
