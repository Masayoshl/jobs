import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/account_type_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/account_type/widgets/type_selector.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:provider/provider.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      appBarWidget: CustomHeader(text: 'Setup Account Type'),
      bodyWidget: AccountTypeBody(),
      bottomWidget: AccountTypeBottom(),
    );
  }
}

class AccountTypeBody extends StatelessWidget {
  const AccountTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin:
                const EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 40),
            height: 16,
            child: LinearProgressIndicator(
              value: 0.15,
              color: purple400,
              backgroundColor: neutralColor500,
              borderRadius: BorderRadius.circular(13),
            )),
        const Padding(
          padding: EdgeInsets.only(bottom: 45, left: 16, right: 16),
          child: Text(
            'Are you in search of employees or employment?',
            style: AppTextStyles.displayTextSemibold,
          ),
        ),
        const SelectTypeWidget(),
      ],
    );
  }
}

class SelectTypeWidget extends StatelessWidget {
  const SelectTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountTypeViewModel>();
    final selectedType =
        context.select((AccountTypeViewModel value) => value.state.accountType);
    return TypeSelector<AccountType>(
      selectedType: selectedType,
      onSelected: model.changeType,
      values: AccountType.values,
    );
  }
}

class AccountTypeBottom extends StatelessWidget {
  const AccountTypeBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountTypeViewModel>();
    final buttonState =
        context.select((AccountTypeViewModel value) => value.state.buttonState);
    return ConfirmButton(
      text: 'Continue',
      onPressed: (_) => model.onButtonPressed(),
      state: buttonState,
      bottom: 0,
      left: 32,
      right: 32,
    );
  }
}
