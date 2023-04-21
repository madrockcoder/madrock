// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../util/text_theme.dart';
// import '../../shared_widgets/custom_progress_indicator.dart';
// import 'appbar_logo.dart';
// import 'next_button.dart';
// import 'socials_sign_in_button.dart';
// import 'terms_and_policies_page.dart';

// enum SignInType { login, signup }

// class SignInPageTemplate extends StatelessWidget {
//   const SignInPageTemplate({
//     Key? key,
//     required this.contentBody,
//     this.signInType = SignInType.login,
//     required this.onActionPressed,
//     required this.onNextButtonPressed,
//     required this.isLoading,
//     this.currIndex,
//     this.topFlex,
//     this.bottomFlex,
//   }) : super(key: key);
//   final Widget contentBody;
//   final SignInType? signInType;
//   final VoidCallback onActionPressed;
//   final VoidCallback? onNextButtonPressed;
//   final bool isLoading;
//   final int? currIndex;
//   final int? topFlex;
//   final int? bottomFlex;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const AppBarLogo(),
//         actions: [
//           TextButton(
//             onPressed: onActionPressed,
//             child: Text(
//               signInType == SignInType.login ? 'SIGN UP' : 'SIGN IN',
//               style: appBarTextStyle,
//             ),
//           ),
//           const SizedBox(width: 19.0),
//         ],
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Column(
//               children: [
//                 Expanded(
//                   flex: topFlex ?? 1,
//                   child: contentBody,
//                 ),
//                 Expanded(
//                   flex: bottomFlex ?? 1,
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                     ),
//                     child: Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 56.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 children: [
//                                   SocialsSignInButton(
//                                     icon: SizedBox(
//                                         width: 60.0,
//                                         child: SvgPicture.asset(
//                                             'assets/images/facebook.svg')),
//                                     onPressed: () {},
//                                     text: 'Sign up with Facebook',
//                                   ),
//                                   const SizedBox(height: 20.0),
//                                   SocialsSignInButton(
//                                     icon: SizedBox(
//                                         width: 60.0,
//                                         child: SvgPicture.asset(
//                                             'assets/images/twitter.svg')),
//                                     onPressed: () {},
//                                     text: 'Sign up with Facebook',
//                                   ),
//                                 ],
//                               ),
//                               GestureDetector(
//                                 onTap: () => TermsAndPoliciesPage.show(context),
//                                 child: Wrap(
//                                   alignment: WrapAlignment.center,
//                                   children: [
//                                     Text(
//                                       'By signing in, you confirm that you agree with our ',
//                                       style: termsTextStyle,
//                                     ),
//                                     Text(
//                                       'Terms & Conditions',
//                                       style: conditionsTextStyle,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           right: 50.0,
//                           top: -25.0,
//                           child: NextButton(
//                             onTap: onNextButtonPressed,
//                             isLoading: isLoading,
//                           ),
//                         ),
//                         if (signInType == SignInType.signup)
//                           Positioned(
//                             left: 25.0,
//                             top: -35.0,
//                             child:
//                                 CustomProgressIndicator(currIndex: currIndex!),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
