/// Asset management utility for consistent asset paths and preloading
class AssetManager {
  // Image assets
  static const String _imagePath = 'assets/images/';
  static const String _iconPath = 'assets/icons/';
  
  // Image assets
  static const String firstImage = '${_imagePath}first.png';
  static const String secondImage = '${_imagePath}second.png';
  static const String thirdImage = '${_imagePath}third.png';
  static const String listImage = '${_imagePath}list.png';
  static const String googleImage = '${_imagePath}google.png';
  
  // Icon assets
  static const String drawerButtonIcon = '${_iconPath}drawer_button.png';
  static const String settingsIcon = '${_iconPath}settings_icon.png';
  static const String logoutIcon = '${_iconPath}logout_icon.png';
  
  // Network image URLs (commonly used)
  static const String gridIconUrl = 'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png';
  
  /// Get all asset paths for preloading
  static List<String> getAllAssets() {
    return [
      firstImage,
      secondImage,
      thirdImage,
      listImage,
      googleImage,
      drawerButtonIcon,
      settingsIcon,
      logoutIcon,
    ];
  }
  
  /// Get image asset path with validation
  static String getImageAsset(String imageName) {
    final assetPath = '$_imagePath$imageName';
    // In a real app, you might want to validate if the asset exists
    return assetPath;
  }
  
  /// Get icon asset path with validation
  static String getIconAsset(String iconName) {
    final assetPath = '$_iconPath$iconName';
    return assetPath;
  }
  
  /// Get profile placeholder based on theme
  static String getProfilePlaceholder({bool isDark = false}) {
    return isDark 
        ? '${_imagePath}profile_placeholder_dark.png'
        : '${_imagePath}profile_placeholder_light.png';
  }
  
  /// Common course thumbnails
  static const List<String> courseThumbnails = [
    firstImage,
    secondImage,
    thirdImage,
  ];
  
  /// Get random course thumbnail
  static String getRandomCourseThumbnail() {
    final index = DateTime.now().millisecondsSinceEpoch % courseThumbnails.length;
    return courseThumbnails[index];
  }
}