import 'package:flutter/material.dart';
import 'package:restaurant_app_3/widgets/fitur_search_custom.dart';

class PlaceHolderCustom extends StatelessWidget {
  final String placeHolderText;
  const PlaceHolderCustom({super.key, required this.placeHolderText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomSearchFitur()),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                placeHolderText,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
