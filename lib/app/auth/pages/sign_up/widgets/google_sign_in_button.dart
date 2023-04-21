import 'package:flutter/material.dart';
import 'package:geniuspay/app/shared_widgets/custom_elevated_button.dart';

class GoogleSignInButton extends CustomElevatedButton {
  GoogleSignInButton(
      {Key? key,
      required bool isLoading,
      required String text,
      required VoidCallback onPressed,
      required BuildContext context})
      : super(
          key: key,
          onPressed: onPressed,
          onPrimary: Theme.of(context).colorScheme.onPrimary,
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const SizedBox(height: 10.0, width: 10.0),
              // backgroundColor: AppColors.kPrimaryColor,
              SizedBox(
                  height: 22.0,
                  width: 22.0,
                  child: Image.asset('assets/images/google-logo.png')),
              FittedBox(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Text(
                        text,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
              ),
              Icon(Icons.chevron_right,
                  color: Theme.of(context).colorScheme.secondary),
            ],
          ),
        );
}
