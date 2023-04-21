import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/shared_widgets/help_icon_button.dart';
import 'package:geniuspay/util/color_scheme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AboutScreen()),
    );
  }

  _buildAbout(
      {required String title,
      required String description,
      required TextTheme textTheme}) {
    return [
      Text(
        title,
        style: textTheme.bodyLarge
            ?.copyWith(color: AppColor.greenbg, fontSize: 18),
      ),
      const Gap(8),
      Text(
        description,
        style: textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
      const Gap(24),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('About'),
          centerTitle: true,
          actions: const [HelpIconButton()],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const Gap(32),
            ..._buildAbout(
                title: 'Our vision',
                description:
                    "Money doesn't grow on trees, but can plant them.\n\n"
                    "Since our beginning, we have held fast to our vision of a world where climate action is embeded into corporate activity. \n\n"
                    "We belive that the path to sustainability should be straighforward for businesses, and just as easy for customers.",
                textTheme: textTheme),
            ..._buildAbout(
                title: 'How we work',
                description:
                    "We help our customers calculate and reduce carbon emissions and offset unabated emissions. This renders products and companies carbon neutral.\n\n"
                    "When you partner with us, our carbon neutral label guarantees transparency and credibility: consumers can use a tracking ID number to trace reduction measures, the chosen carbon offset project, the amount of CO2 compensated and more information such as the Sustainable Development Goals of the project.",
                textTheme: textTheme),
            ..._buildAbout(
                title: 'Our projects',
                description:
                    "We offer carbon offset projects which comply to recognized standards, such as the Gold Standard or the Verified Carbon Standard. These projects operate in different regions with various technologies and are geared towards the 17 Sustainable Development Goals (SDGs) of the United Nations—their additional social benefits are particularly important to us",
                textTheme: textTheme),
            ..._buildAbout(
                title: 'Taking Climate Action to Heart',
                description:
                    "We start with ourselves: we are proudly a carbon neutral company. Here are some of the ways we operate sustainably:\n\n"
                    "• Based on our own corporate carbon footprint, our consulting team is always working on reduction options. We offset all unabated emissions and have put in place measures that can be implemented quickly.\n"
                    "• It goes without saying that we use green electricity in all of our company buildings. For our headquarters in London, we have gone one step further and operate in a “smart house”.\n"
                    "• Sustainability is also important to us when it comes to commuting to the office: all of our locations are easily accessible by public transport, so our employees do not need a car to get to work. All employees in UK have been able to use bicycle leasing through the company. We also provide our employees with an electric scooter.\n"
                    "• Whether it's coffee, sending parcels, printing in our offices or birthday gifts for employees: wherever possible, we buy products and services that are carbon neutral.",
                textTheme: textTheme),
            const Gap(24),
          ],
        ));
  }
}
