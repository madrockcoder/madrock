import 'package:geniuspay/app/home/pages/home_page_designs/models/home_page_design_model.dart';
import 'package:geniuspay/util/color_scheme.dart';

// Add new design page in this enum
enum HomePageDesigns {
  sendMoney,
  refer,
  twoFactorAuthentication,
  interest,
  plantTree,
  hybridWallet,
  connect
}

HomePageDesignModel getHomePageDesignModel(HomePageDesigns homePageDesigns) {
  HomePageDesignModel homePageDesignModel;
  switch (homePageDesigns) {
    case HomePageDesigns.sendMoney:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.kGreen,
          imageTopSpacing: 16,
          imageHorizontalPadding: 24,
          title: "Send money across borders!",
          subtitle:
              "Send money between countries\ninstantly, with the best rates!",
          asset: "assets/home_designs/design_1.png",
          buttonText: "MAKE BORDERLESS TRANSFERS");
      break;
    case HomePageDesigns.refer:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.kblue,
          imageTopSpacing: 16,
          imageHorizontalPadding: 54,
          title: "It’s better with friends.\nRefer & Earn.",
          subtitle:
              "Invite your friends to geniuspay and earn 100\npoints when they make their first transfer.",
          asset: "assets/home_designs/design_2.png",
          buttonText: "INVITE YOUR FRIENDS");
      break;
    case HomePageDesigns.twoFactorAuthentication:
      homePageDesignModel = HomePageDesignModel(
          imageTopSpacing: 16,
          imageHorizontalPadding: 34,
          backgroundColor: AppColor.kpurple,
          title: "Ironclad security to\nprotect your money",
          subtitle:
              "Enable 2-Factor authentication to make your\naccount even more secure.",
          asset: "assets/home_designs/design_3.png",
          buttonText: "INVITE YOUR FRIENDS");
      break;
    case HomePageDesigns.interest:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.kred,
          imageTopSpacing: 16,
          imageHorizontalPadding: 60,
          title: "Have a financial goal?\nSaving towards it made easy.",
          subtitle: "Earn up to 7%  per annum when you save\nwith geniuspay.",
          asset: "assets/home_designs/design_4.png",
          buttonText: "CREATE A JAR");
      break;
    case HomePageDesigns.plantTree:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.klemon,
          imageTopSpacing: 45,
          imageHorizontalPadding: 24,
          title: "Help fight climate change",
          subtitle: "Use your points to plant trees and\nsave the planet.",
          asset: "assets/home_designs/design_5.png",
          buttonText: "PLANT A TREE");
      break;
    case HomePageDesigns.hybridWallet:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.korange,
          imageTopSpacing: 54,
          imageHorizontalPadding: 24,
          title: "Hybrid Wallet",
          subtitle: "Send, receive and convert in over\n70 currencies.",
          asset: "assets/home_designs/design_6.png",
          buttonText: "CREATE A WALLET");
      break;
    case HomePageDesigns.connect:
      homePageDesignModel = HomePageDesignModel(
          backgroundColor: AppColor.kbrown,
          imageTopSpacing: 20,
          imageHorizontalPadding: 24,
          title: "Connect better with your\ncustomers",
          subtitle:
              "Take control of your cash flow by leveraging geniuspay to receive and send money from and to clients.",
          asset: "assets/home_designs/design_7.png",
          buttonText: "CREATE A WALLET");
      break;
  }
  return homePageDesignModel;
}
