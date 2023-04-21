import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton(
      {Key? key,
      required bool isLoading,
      required String text,
      required VoidCallback onPressed,
      required BuildContext context})
      : super(
          key: key,
          onPressed: onPressed,
          onPrimary: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.secondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10.0, width: 10.0),
              // const CircleAvatar(
              //   radius: 10.0,
              //   backgroundColor: AppColors.kPrimaryColor,
              //   backgroundImage: AssetImage('assets/images/google-logo.png'),
              // ),
              FittedBox(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Text(
                        text,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
              ),
              Icon(Icons.chevron_right,
                  color: Theme.of(context).colorScheme.primary),
            ],
          ),
        );
  // : super(
  //     key: key,
  //     radius: 10.0,
  //     onPre,
  //     color: Theme.of(context).colorScheme.secondary,
  //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 22.0),
  //     onPressed: onPressed,
  // child: Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     const SizedBox(height: 10.0, width: 10.0),
  //     // const CircleAvatar(
  //     //   radius: 10.0,
  //     //   backgroundColor: AppColors.kPrimaryColor,
  //     //   backgroundImage: AssetImage('assets/images/google-logo.png'),
  //     // ),
  //     FittedBox(
  //       child: isLoading
  //           ? const Center(child: CircularProgressIndicator.adaptive())
  //           : Text(
  //               text,
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .headline6
  //                   ?.copyWith(color: Theme.of(context).colorScheme.primary),
  //             ),
  //     ),
  //      Icon(Icons.chevron_right, color:Theme.of(context).colorScheme.secondary),
  //   ],
  // ),
  //   );
}
