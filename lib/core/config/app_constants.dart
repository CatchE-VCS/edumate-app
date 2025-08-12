import 'package:flutter/material.dart';

/// Application-wide constants for consistent styling and values
class AppConstants {
  // Spacing Constants
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 16.0;
  static const double spaceLG = 24.0;
  static const double spaceXL = 32.0;
  static const double spaceXXL = 48.0;
  
  // Border Radius Constants
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusRound = 50.0;
  
  // Elevation Constants
  static const double elevationNone = 0.0;
  static const double elevationXS = 1.0;
  static const double elevationSM = 2.0;
  static const double elevationMD = 4.0;
  static const double elevationLG = 8.0;
  static const double elevationXL = 16.0;
  
  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 32.0;
  static const double iconXL = 48.0;
  
  // Font Sizes
  static const double fontXS = 12.0;
  static const double fontSM = 14.0;
  static const double fontMD = 16.0;
  static const double fontLG = 18.0;
  static const double fontXL = 20.0;
  static const double fontXXL = 24.0;
  static const double font3XL = 32.0;
  
  // Line Heights
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;
  
  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Button Heights
  static const double buttonHeightSM = 32.0;
  static const double buttonHeightMD = 40.0;
  static const double buttonHeightLG = 48.0;
  static const double buttonHeightXL = 56.0;
  
  // Input Field Heights
  static const double inputHeightSM = 36.0;
  static const double inputHeightMD = 44.0;
  static const double inputHeightLG = 52.0;
  
  // Layout Constants
  static const double maxContentWidth = 1200.0;
  static const double sidebarWidth = 280.0;
  static const double bottomNavHeight = 60.0;
  static const double appBarHeight = 56.0;
  
  // Grid Constants
  static const int gridColumnsXS = 1;
  static const int gridColumnsSM = 2;
  static const int gridColumnsMD = 3;
  static const int gridColumnsLG = 4;
  static const int gridColumnsXL = 6;
  
  // Aspect Ratios
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatio4_3 = 4.0 / 3.0;
  static const double aspectRatio16_9 = 16.0 / 9.0;
  static const double aspectRatio3_2 = 3.0 / 2.0;
  
  // Z-Index Constants
  static const int zIndexBase = 0;
  static const int zIndexDropdown = 1000;
  static const int zIndexModal = 2000;
  static const int zIndexPopover = 3000;
  static const int zIndexTooltip = 4000;
  static const int zIndexToast = 5000;
  
  // Common Edge Insets
  static const EdgeInsets paddingXS = EdgeInsets.all(spaceXS);
  static const EdgeInsets paddingSM = EdgeInsets.all(spaceSM);
  static const EdgeInsets paddingMD = EdgeInsets.all(spaceMD);
  static const EdgeInsets paddingLG = EdgeInsets.all(spaceLG);
  static const EdgeInsets paddingXL = EdgeInsets.all(spaceXL);
  
  static const EdgeInsets paddingHorizontalXS = EdgeInsets.symmetric(horizontal: spaceXS);
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(horizontal: spaceSM);
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(horizontal: spaceMD);
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(horizontal: spaceLG);
  static const EdgeInsets paddingHorizontalXL = EdgeInsets.symmetric(horizontal: spaceXL);
  
  static const EdgeInsets paddingVerticalXS = EdgeInsets.symmetric(vertical: spaceXS);
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(vertical: spaceSM);
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(vertical: spaceMD);
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(vertical: spaceLG);
  static const EdgeInsets paddingVerticalXL = EdgeInsets.symmetric(vertical: spaceXL);
  
  // Common Border Radius
  static const BorderRadius borderRadiusXS = BorderRadius.all(Radius.circular(radiusXS));
  static const BorderRadius borderRadiusSM = BorderRadius.all(Radius.circular(radiusSM));
  static const BorderRadius borderRadiusMD = BorderRadius.all(Radius.circular(radiusMD));
  static const BorderRadius borderRadiusLG = BorderRadius.all(Radius.circular(radiusLG));
  static const BorderRadius borderRadiusXL = BorderRadius.all(Radius.circular(radiusXL));
  
  // Text Styles
  static const TextStyle textStyleXS = TextStyle(fontSize: fontXS, height: lineHeightNormal);
  static const TextStyle textStyleSM = TextStyle(fontSize: fontSM, height: lineHeightNormal);
  static const TextStyle textStyleMD = TextStyle(fontSize: fontMD, height: lineHeightNormal);
  static const TextStyle textStyleLG = TextStyle(fontSize: fontLG, height: lineHeightNormal);
  static const TextStyle textStyleXL = TextStyle(fontSize: fontXL, height: lineHeightNormal);
  
  // Weight variations
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemibold = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;
  static const FontWeight weightExtrabold = FontWeight.w800;
  
  // Box Shadows
  static const BoxShadow shadowXS = BoxShadow(
    color: Colors.black12,
    blurRadius: 2,
    offset: Offset(0, 1),
  );
  
  static const BoxShadow shadowSM = BoxShadow(
    color: Colors.black12,
    blurRadius: 4,
    offset: Offset(0, 2),
  );
  
  static const BoxShadow shadowMD = BoxShadow(
    color: Colors.black12,
    blurRadius: 8,
    offset: Offset(0, 4),
  );
  
  static const BoxShadow shadowLG = BoxShadow(
    color: Colors.black12,
    blurRadius: 16,
    offset: Offset(0, 8),
  );
  
  // Lists of common shadows
  static const List<BoxShadow> shadowsXS = [shadowXS];
  static const List<BoxShadow> shadowsSM = [shadowSM];
  static const List<BoxShadow> shadowsMD = [shadowMD];
  static const List<BoxShadow> shadowsLG = [shadowLG];
}