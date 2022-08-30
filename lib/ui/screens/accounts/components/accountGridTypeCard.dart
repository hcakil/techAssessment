

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../features/accounts/account.dart';



class AccountGridTypeCard extends StatelessWidget {
  final Account d;
  //final String heroTag;
  const AccountGridTypeCard({  required this.d, }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0,3),
                      color: Theme.of(context).shadowColor
                  )
                ]

            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    d.category.contains("Animals") ?    "assets/images/animals.png" :
                    d.category.contains("Anime") ?    "assets/images/anime.png" :
                    d.category.contains("Anti-Malware") ?    "assets/images/malware.png"
                        :"assets/images/art.png",)
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 15, right: 10,top: 5),
                    child: Text(d.description, style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6
                    ),),
                  ),
                )


              ],
            )
        ),

          onTap: () {
            context.router.push(AccountDetailRoute(data: d));

          },


      ),
    );
  }
}
