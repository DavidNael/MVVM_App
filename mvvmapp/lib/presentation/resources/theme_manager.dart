import 'package:flutter/material.dart';
import 'package:mvvmapp/presentation/resources/style_manager.dart';
import 'package:mvvmapp/presentation/resources/values_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getRegularTextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),
    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularTextStyle(
            fontSize: FontSize.s17, color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12)),
        ),
      ),
    ),
    // Text button theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldTextStyle(
        color: ColorManager.darkGrey,
        fontSize: FontSize.s16,
      ),
      displayMedium: getRegularTextStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s14,
      ),
      displaySmall: getRegularTextStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getMediumTextStyle(
        fontSize: FontSize.s16,
        color: ColorManager.primary,
      ),
      bodyMedium: getMediumTextStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s14,
      ),
      bodySmall: getMediumTextStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s12,
      ),
    ),
    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      hintStyle: getRegularTextStyle(
        fontSize: FontSize.s14,
        color: ColorManager.grey,
      ),

      labelStyle: getMediumTextStyle(
        fontSize: FontSize.s14,
        color: ColorManager.grey,
      ),

      errorStyle: getRegularTextStyle(
        fontSize: FontSize.s12,
        color: ColorManager.error,
      ),

      // Enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // Focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),

      // Error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      // Focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
