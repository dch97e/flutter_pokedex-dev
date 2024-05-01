import 'dart:ui';

class AppColors {
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color backgroundGrey = Color(0xFFF2F2F2);
  static const Color primaryRed = Color(0xFFFF0000);
  static const Color bostonRed = Color(0xFFCC0000);
  static const Color ceruleanBlue = Color(0xFF3B4CCA);
  static const Color goldenYellow = Color(0xFFFFDE00);
  static const Color goldFoil = Color(0xFFB3A125);

  static const Color normalColor = Color(0xFFAAB09F);
  static const Color fightingColor = Color(0xFFCB5F48);
  static const Color flyingColor = Color(0xFF7DA6DE);
  static const Color poisonColor = Color(0xFFB468B7);
  static const Color groundColor = Color(0xFFCC9F4F);
  static const Color rockColor = Color(0xFFB2A061);
  static const Color bugColor = Color(0xFF94BC4A);
  static const Color ghostColor = Color(0xFF846AB6);
  static const Color steelColor = Color(0xFF89A1B0);
  static const Color fireColor = Color(0xFFEA7A3C);
  static const Color waterColor = Color(0xFF539AE2);
  static const Color grassColor = Color(0xFF71C558);
  static const Color electricColor = Color(0xFFE5C531);
  static const Color psychicColor = Color(0xFFE5709B);
  static const Color iceColor = Color(0xFF70CBD4);
  static const Color dragonColor = Color(0xFF6A7BAF);
  static const Color darkColor = Color(0xFF736C75);
  static const Color fairyColor = Color(0xFFE397D1);
  static const Color unknownColor = Color(0xFFD2B4DE);
  static const Color shadowColor = Color(0xFF5D6D7E);

  static Color getColorType(String type) {
    switch (type) {
      case "normal":
        return AppColors.normalColor;
      case "fighting":
        return AppColors.fightingColor;
      case "flying":
        return AppColors.flyingColor;
      case "poison":
        return AppColors.poisonColor;
      case "ground":
        return AppColors.groundColor;
      case "rock":
        return AppColors.rockColor;
      case "bug":
        return AppColors.bugColor;
      case "ghost":
        return AppColors.ghostColor;
      case "steel":
        return AppColors.steelColor;
      case "fire":
        return AppColors.fireColor;
      case "water":
        return AppColors.waterColor;
      case "grass":
        return AppColors.grassColor;
      case "electric":
        return AppColors.electricColor;
      case "psychic":
        return AppColors.psychicColor;
      case "ice":
        return AppColors.iceColor;
      case "dragon":
        return AppColors.dragonColor;
      case "dark":
        return AppColors.darkColor;
      case "fairy":
        return AppColors.fairyColor;
      case "unknown":
        return AppColors.unknownColor;
      case "shadow":
        return AppColors.shadowColor;
    }
    return AppColors.unknownColor;
  }
}
