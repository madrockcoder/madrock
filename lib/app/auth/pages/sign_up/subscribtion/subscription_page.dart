import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:geniuspay/app/KYC/pages/kyc_id_verification/proof_of_identity.dart';
import 'package:geniuspay/app/auth/pages/sign_up/subscribtion/models/subscription_model.dart';
import 'package:geniuspay/app/auth/pages/sign_up/widgets/auth_provider.dart';
import 'package:geniuspay/app/shared_widgets/continue_button.dart';
import 'package:geniuspay/util/color_scheme.dart';
import 'package:geniuspay/util/constants.dart';
import 'package:geniuspay/util/enums.dart';
import 'package:geniuspay/util/widgets_util.dart';
import 'package:provider/provider.dart';

import 'models/subcription_list.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key, required this.authProvider})
      : super(key: key);
  final AuthProvider authProvider;

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => Consumer<AuthProvider>(
          builder: (_, authProvider, __) =>
              SubscriptionPage(authProvider: authProvider),
        ),
      ),
    );
  }

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionModal? selectedSubscription;
  bool _terms = false;
  @override
  Widget build(BuildContext context) {
    final list = widget.authProvider.userType == UserType.business
        ? SubscriptionList.business
        : SubscriptionList.personal;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: WidgetsUtil.onBoardingAppBar(
        context,
        title: '',
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: commonPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your\nsubscription plan',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColor.kOnPrimaryTextColor2,
                      fontSize: 30,
                    ),
              ),
              const Gap(20),
              Container(
                height: 32,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    width: 2,
                    color: AppColor.kSubscriptionColor,
                  ),
                ),
                child: Row(
                  children: [
                    SubscriptionTabWidget(
                      isSelected:
                          widget.authProvider.userType == UserType.personal,
                      text: 'Personal',
                      onTap: () {
                        setState(() {
                          widget.authProvider
                              .updateWith(userType: UserType.personal);
                          selectedSubscription = null;
                        });
                      },
                    ),
                    SubscriptionTabWidget(
                      isSelected:
                          widget.authProvider.userType == UserType.business,
                      text: 'Business',
                      onTap: () {
                        setState(() {
                          widget.authProvider
                              .updateWith(userType: UserType.business);
                          selectedSubscription = null;
                        });
                        SubscriptionTypeModal.show(context);
                      },
                    ),
                  ],
                ),
              ),
              const Gap(32),
              Column(
                children: [
                  for (var item in list)
                    SubscriptionWidget(
                      subscription: item,
                      isSelected: selectedSubscription != null &&
                          selectedSubscription!.name == item.name,
                      onTap: () {
                        setState(() {
                          selectedSubscription = item;
                        });
                      },
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Compare Plans',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                  ),
                  const Gap(10),
                  SvgPicture.asset('assets/images/forward.svg'),
                ],
              ),
              const Gap(30),
              InkWell(
                onTap: () {
                  setState(() {
                    _terms = true;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Radio(
                      value: _terms,
                      activeColor: Colors.black,
                      groupValue: true,
                      onChanged: (value) {
                        setState(() {
                          _terms = true;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          text: 'I have read the terms of the ',
                          children: const [
                            TextSpan(
                              text: 'Premium ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: 'subscription plan, ',
                            ),
                            TextSpan(
                              text:
                                  'General Terms and Conditions of Provision of Service, ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'compared it with other geniuspay\nsubscription plans and agree to choose the\n',
                            ),
                            TextSpan(
                              text: 'Premium ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                              text: 'subscription plan.',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Gap(30),
              ContinueButton(
                context: context,
                color: AppColor.kGoldColor2,
                textColor: Colors.black,
                onPressed: () {
                  ProofIdentity.show(context);
                },
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({
    Key? key,
    required this.subscription,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);
  final SubscriptionModal subscription;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.kAccentColor2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.black : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.done,
                              size: 18,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 18),
                        ),
                        Text(
                          subscription.fee ?? 'free',
                          style:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.kSubscriptionColor,
                                    fontSize: 18,
                                  ),
                        ),
                        const Gap(11),
                        for (var item in subscription.offers)
                          Row(
                            children: [
                              const Icon(
                                Icons.done,
                                size: 20,
                              ),
                              const Gap(5),
                              Expanded(
                                child: Text(
                                  item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (subscription.best != null)
              Positioned(
                top: 0,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColor.kSubscriptionColor,
                  child: Center(
                    child: Text(
                      subscription.best!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class SubscriptionTypeModal extends StatelessWidget {
  const SubscriptionTypeModal({
    Key? key,
  }) : super(key: key);

  static show(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return const SubscriptionTypeModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(40),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to open a Business account?',
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                color: AppColor.kSubscriptionColor,
              ),
            ),
            Text(
              '1. A Company representative opens a private account.\n \n2. Log in to the Online Bank as private person and press the ‘Open Business account\' button.\n \n3. Fill in the main details about the Company and choose a subscription plan based on the Company\'s monthly incoming turnover.\n \n4. Pay the fee for the first verification of the documents and get access to Company profile in Online Bank.\n \n5. Fill in the full Company questionnaire and add Company documents.\n \n6. Get your Company\'dd Business account!',
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionTabWidget extends StatelessWidget {
  const SubscriptionTabWidget(
      {Key? key,
      required this.isSelected,
      required this.text,
      required this.onTap})
      : super(key: key);
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color:
                isSelected ? AppColor.kSubscriptionColor : Colors.transparent,
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: isSelected ? 14 : 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
