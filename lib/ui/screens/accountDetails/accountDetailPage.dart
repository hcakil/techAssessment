


import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'dart:io';

import '../../../features/accounts/account.dart';
import '../../../utils/customColor.dart';
import 'components/isSecure.dart';
import 'components/webUrl.dart';


class AccountDetailScreen extends StatefulWidget {
  final Account? data;



  const AccountDetailScreen({Key? key, required this.data})
      : super(key: key);

  @override
  _AccountDetailScreenState createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {


  double rightPaddingValue = 140;



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        rightPaddingValue = 10;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final Account account = widget.data!;

    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: SafeArea(
          bottom: true,
          top: false,
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[
                    _customAppBar( context,widget.data!),
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color:  CustomColor().loadingColorLight
                                            ,
                                        ),
                                        child: AnimatedPadding(
                                          duration: Duration(milliseconds: 1000),
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              right: rightPaddingValue,
                                              top: 5,
                                              bottom: 5),
                                          child: Text(
                                            "Cors: ${account.cors.toUpperCase()}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                    const Spacer(),

                                   Container(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    const Icon(CupertinoIcons.time_solid,
                                        size: 18, color: Colors.grey),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        DateFormat.yMMMMEEEEd().format(DateTime.now())
                                      ,//account.openrevenueDate.toIso8601String(),
                                      style: TextStyle(
                                          color: CustomColor().categoryAnimationColorDark,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  account.api,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.6,
                                      wordSpacing: 1
                                  ),
                                ),
                                Divider(
                                  color: CustomColor().sliverHeaderColorLight,
                                  endIndent: 200,
                                  thickness: 2,
                                  height: 20,
                                ),


                                const SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    //views feature
                                    IsSecure(account: account,),
                                    const SizedBox(width: 20,),

                                    WebUrl(webUrl: account.link),


                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(account.description),
                                //HtmlBodyWidget(htmlData: account.description!,),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),



            ],
          ),
        ));
  }



  SliverAppBar _customAppBar( BuildContext context,Account d) {
    return SliverAppBar(
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(

            d.category.contains("Animals") ?    "assets/images/animals.png" :
            d.category.contains("Anime") ?    "assets/images/anime.png" :
            d.category.contains("Anti-Malware") ?    "assets/images/malware.png"
                :"assets/images/art.png",

            fit: BoxFit.cover,)

              ),
      leading: IconButton(

        icon:  Icon(Icons.keyboard_backspace, size: 25, color: CustomColor().sliverHeaderColorLight),
        onPressed: () {
          context.router.pop();
        },
      ),

    );
  }
}
