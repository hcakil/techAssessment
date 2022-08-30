
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../features/accounts/cubits/accountsCubit.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: kIsWeb ? MediaQuery.of(context).size.width * 0.4 :  MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: Colors.grey[400]!, width: 0.5),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            autofocus: true,
            //controller: context.watch<SearchBloc>().textfieldCtrl,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Ara",
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).secondaryHeaderColor),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 25,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
              //pressed action will be use if needs
                },
              ),
            ),
            textInputAction: TextInputAction.search,
           onChanged: (value1){

              context.read<AccountsCubit>().filterAccounts(value1);


           },

          ),
        ),
      ),
    );
  }
}
