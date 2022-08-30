
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class WebUrl extends StatelessWidget {
  final String webUrl;

  const WebUrl({Key? key, required this.webUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.web_rounded,
          color: Colors.grey[500],
          size: 18,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          webUrl,
          style: const TextStyle(
              fontSize: kIsWeb ? 15 : 9,
              fontWeight: FontWeight.w600,
              color: Colors.grey),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          '',
          maxLines: 1,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
        )
      ],
    );
  }
}
