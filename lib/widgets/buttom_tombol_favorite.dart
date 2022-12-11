import 'package:flutter/material.dart';
import 'package:restaurant_app_3/style/customStyle.dart';

class CustomTombolFavorite extends StatelessWidget {
  final void Function()? onTap;
  final String labelFavorite;
  final Color colorTextFavorite, backgroundColorFavorite;
  final bool isLoadingFavorite;
  final double verticalPaddingFavorite;
  const CustomTombolFavorite({
    super.key,
    required this.onTap,
    required this.labelFavorite,
    this.colorTextFavorite = Colors.white,
    this.isLoadingFavorite = false,
    this.verticalPaddingFavorite = 17,
    this.backgroundColorFavorite = primary,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColorFavorite,
          padding: EdgeInsets.symmetric(vertical: verticalPaddingFavorite),
        ),
        child: isLoadingFavorite
            ? SizedBox(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                labelFavorite,
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: colorTextFavorite,
                    ),
              ),
      ),
    );
  }
}
