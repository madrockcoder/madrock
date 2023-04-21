import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geniuspay/util/color_scheme.dart';

class GroupScreenContent1 extends StatefulWidget {
  const GroupScreenContent1({Key? key}) : super(key: key);

  @override
  State<GroupScreenContent1> createState() => _GroupScreenContent1State();
}

class _GroupScreenContent1State extends State<GroupScreenContent1> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 300,
          width: 800,
          // color: Colors.amber,
          child: SvgPicture.asset('assets/groups/group1.svg',
              fit: BoxFit.fitWidth),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            'Group help you live life in Easy mode',
            textAlign: TextAlign.center,
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
        Text(
          'Make a group to manage costs when you travel with friends or for sharing utilities',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class GroupScreenContent2 extends StatefulWidget {
  const GroupScreenContent2({Key? key}) : super(key: key);

  @override
  State<GroupScreenContent2> createState() => _GroupScreenContent2State();
}

class _GroupScreenContent2State extends State<GroupScreenContent2> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/groups/group2.png',
          fit: BoxFit.contain,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            'With Groups, even those who still don\'t have geniuspay can be included',
            textAlign: TextAlign.center,
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
        Text(
          'All you need is their phone number and you can split costs with them as well',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      ],
    );
  }
}

class GroupScreenContent3 extends StatefulWidget {
  const GroupScreenContent3({Key? key}) : super(key: key);

  @override
  State<GroupScreenContent3> createState() => _GroupScreenContent3State();
}

class _GroupScreenContent3State extends State<GroupScreenContent3> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/groups/group3.png',
          fit: BoxFit.contain,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            'Who needs calculators?',
            textAlign: TextAlign.center,
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 5),
          child: Text(
            'We automatically calculate who owes what and to whom',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}

class GroupScreenContext4 extends StatefulWidget {
  const GroupScreenContext4({Key? key}) : super(key: key);

  @override
  State<GroupScreenContext4> createState() => _GroupScreenContext4State();
}

class _GroupScreenContext4State extends State<GroupScreenContext4> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/groups/group3.png',
          fit: BoxFit.contain,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            'Paid in cash? No problem',
            textAlign: TextAlign.center,
            style:
                textTheme.displaySmall?.copyWith(color: AppColor.kSecondaryColor),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 5),
          child: Text(
            'Even if a payment was made outside of the Group, mark it as "Paid" and the debt will adjust accordingly',
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
