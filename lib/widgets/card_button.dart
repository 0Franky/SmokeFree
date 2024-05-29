import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CardButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(Icons.add, size: 32.0),
                SizedBox(height: 16.0),
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
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
