import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String teks;
  final void Function()? onTap;

  const UserTile({
    Key? key,
    required this.teks,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey), // Add border decoration
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Icon(Icons.person),
                SizedBox(width: 8), // Add space between icon and text
                Expanded(
                  child: Text(
                    teks,
                    style: TextStyle(fontSize: 16), // Adjust as needed
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
