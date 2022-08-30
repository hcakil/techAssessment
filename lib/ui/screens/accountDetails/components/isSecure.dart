
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../features/accounts/account.dart';




class IsSecure extends StatefulWidget {

  final Account account;
  const IsSecure({
    Key? key, required this.account,
  }) : super(key: key);

  @override
  _IsSecureState createState() => _IsSecureState();
}

class _IsSecureState extends State<IsSecure> {

  @override
  void initState() {

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final String collectionName = 'contents';

    
    return Container(
      child: Row(
        children: [
          const Icon(Feather.shield, color: Colors.grey, size: 20,),
          const SizedBox(width: 3,),
          Text(
          widget.account.https.toString().toUpperCase(),
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),

          const SizedBox(width: 3,),

          const Text('Secure',
            maxLines: 1,
            style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      ),
    );
  }
}