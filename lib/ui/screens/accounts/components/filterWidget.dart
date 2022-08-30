
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:provider/provider.dart';

import '../../../../features/accounts/cubits/accountsCubit.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  bool isFilterIcon = true;

  @override
  Widget build(BuildContext context) {

    return Padding(

        padding: kIsWeb ?  EdgeInsets.only(left:  isFilterIcon ? 20.0: 10 , right:isFilterIcon ? 40 : 10)
                        : EdgeInsets.only(left:  isFilterIcon ? 10:0 , right:isFilterIcon ? 10:0),
        child: Column(
          children: [
            isFilterIcon
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<AccountsCubit>().filterAccountsBasedOnApi("All");
                          setState(() {
                            isFilterIcon = false;
                          });
                        },
                        child: Icon(
                          Icons.filter_list_alt,
                          size: 25,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const Text("Filter")
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,

                    children: [
                   /*   Text('Api',
                          style: boldTextStyle(size: 11)),
                      8.height,*/
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Container(
                          height: context.height() * 0.04,
                          width: context.width() * 0.20,
                          decoration: BoxDecoration(
                              borderRadius: radius(),
                              color: Colors.grey.shade200),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          child: DropdownButton(
                            underline: const Offstage(),
                            items:context.read<AccountsCubit>().stateFilterList.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.validate(),style: TextStyle(fontSize: 12),));
                            }).toList(),
                            isExpanded: true,
                            value:       context.read<AccountsCubit>().stateFilterElement,
                            onChanged: (dynamic c) async {

                              context.read<AccountsCubit>().filterAccountsBasedOnApi(c);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ));
  }
}
