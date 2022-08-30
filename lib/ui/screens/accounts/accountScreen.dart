import 'dart:developer';

import 'package:etiyatechassessment/utils/customColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../app/appLocalization.dart';
import '../../../features/accounts/cubits/accountsCubit.dart';
import '../../../utils/constants.dart';
import '../../../utils/errorMessageKeys.dart';
import '../../../utils/uiUtils.dart';
import '../../widgets/circularProgressContainner.dart';
import '../../widgets/errorContainer.dart';
import '../../widgets/pageBackgroundGradientContainer.dart';
import 'components/accountGridTypeCard.dart';
import 'components/accountListTypeCard.dart';
import 'components/customSearchBar.dart';
import 'components/filterWidget.dart';
import 'components/typeChange.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fillValues();
  }

  Future<void> fillValues() async {
//    Future.delayed(Duration.zero, () {
    context.read<AccountsCubit>().getAccounts();
    /*  }).then((value) {
      setState(() {
        isLoading = false;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mobile Tech",
          style: TextStyle(color: CustomColor().categoryAnimationColorLight),
        ),
        backgroundColor: CustomColor().appBarColorLight,
      ),
      key: _scaffoldKey,
      body: BlocConsumer<AccountsCubit, AccountsState>(
        listener: (context, state) {
          if (state is AccountsFetchSuccess) {
            UiUtils.fetchAccounts(
              context: context,
            );
          } else if (state is AccountsFetchFailure) {
            if (state.errorMessage == unauthorizedAccessCode) {
              //  UiUtils.showAlreadyLoggedInDialog(context: context);
            }
          }
        },
        bloc: context.read<AccountsCubit>(),
        builder: (context, state) {
          if (state is AccountsFetchInProgress || state is AccountsInitial) {
            return _buildHomeScreen([
              Row(
                children: const [
                 // CustomSearchBar(),
                 // FilterWidget(),
                 // TypeChangeWidget(),
                  SizedBox(height: 10,width: 10,)
                ],
              ),
              Center(
                child: CircularProgressContainer(
                  useWhiteLoader: false,
                ),
              )
            ]);
          }
          if (state is AccountsFetchFailure) {
            return _buildHomeScreen([
              ErrorContainer(
                showBackButton: true,
                errorMessage: "Something went wrong",
                onTapRetry: () {
                  context.read<AccountsCubit>().getAccounts();
                },
                showErrorImage: true,
                errorMessageColor: Theme.of(context).primaryColor,
              )
            ]);
          }
          return _buildHomeScreen([
            Row(
              children:  const [
                CustomSearchBar(),
                SizedBox(height: 30,width: 100, child: FilterWidget()),
                TypeChangeWidget(),
              ],
            ),
            context.read<AccountsCubit>().isList
                ? listWidget(context)
                : gridWidget(context),
          ]);
        },
      ),
    );
  }

  Widget _buildHomeScreen(List<Widget> children) {
    return Stack(
      children: [
        const PageBackgroundGradientContainer(),
        ...children,
      ],
    );
  }

  Padding gridWidget(
    BuildContext context, // AccountBloc qb
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .9,
        child: GridView.builder(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1),
          itemCount: context.read<AccountsCubit>().accountSearchList.isNotEmpty
              ? context.read<AccountsCubit>().accountSearchList.length + 1
              : 10,
          itemBuilder: (_, int index) {
            if (index <
                context.read<AccountsCubit>().accountSearchList.length) {
              return AccountGridTypeCard(
                  d: context.read<AccountsCubit>().accountSearchList[index]);
            }
            return const SizedBox(
              width: 32.0,
              height: 32.0,
            );
          },
        ),
      ),
    );
  }

  Padding listWidget(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Container(
        height: MediaQuery.of(context).size.height * .7,
        color: Colors.white,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
          //  controller: controller,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: context.read<AccountsCubit>().accountSearchList.isNotEmpty
              ? context.read<AccountsCubit>().accountSearchList.length + 1
              : 5,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 15,
          ),
          shrinkWrap: true,
          itemBuilder: (_, int index) {
            if (index <
                context.read<AccountsCubit>().accountSearchList.length) {
              return AccountListTypeCard(
                d: context.read<AccountsCubit>().accountSearchList[index],
              );
            }
            return const SizedBox(
              width: 32.0,
              height: 32.0,
            );
          },
        ),
      ),
    );
  }
}
