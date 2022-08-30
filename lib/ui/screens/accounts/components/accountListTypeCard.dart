import 'package:auto_route/auto_route.dart';
import 'package:etiyatechassessment/app/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../features/accounts/account.dart';
import '../../../../utils/constants.dart';

class AccountListTypeCard extends StatelessWidget {
  final Account d;

  //final String heroTag;
  const AccountListTypeCard({
    required this.d,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          child: Container(
              height: MediaQuery.of(context).size.height / 7.0, // 103,

              //padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  //Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 10,
                        offset: const Offset(0, 3))
                  ]),
              child: Column(
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                //  constraints: BoxConstraints.expand(),

                                height:
                                    MediaQuery.of(context).size.height / 7.2,
                                width: MediaQuery.of(context).size.height / 7.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //color: secondaryColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Image.asset(
                                d.category.contains("Animals") ?    "assets/images/animals.png" :
                                d.category.contains("Anime") ?    "assets/images/anime.png" :
                                d.category.contains("Anti-Malware") ?    "assets/images/malware.png"
                                                                :"assets/images/art.png",
                                  ),
                                )
                                //   Container(),
                                ),
                            // VideoIcon(contentType: d.contentType, iconSize: 40,)
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                d.category.isNotEmpty ? d.category : "Category",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),

                                // color: Colors.blueGrey[600]
                              ),
                              child: d.description.isNotEmpty
                                  ? Text(
                                      d.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    )
                                  : const Text("Description"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          onTap: () {
        //    context.router.replace( AccountDetailRoute(data: d));
            context.router.push(AccountDetailRoute(data: d));
          } // =>nextScreeniOS(context, AccountDetail(data: d,)),
          //navigateToDetailsScreen(context, d, heroTag),
          ),
    );
  }
}
