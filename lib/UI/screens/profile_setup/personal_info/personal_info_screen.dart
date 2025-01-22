import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/personal_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/widgets.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/dashed_line_text.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/skip_text_button.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/widgets.dart';

import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(text: 'Setup your Profile'),
      content: PersonalInfoBody(),
      footer: PersonalInfoBottom(),
    );
  }
}

class PersonalInfoBody extends StatelessWidget {
  const PersonalInfoBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 40),
            height: 16,
            child: LinearProgressIndicator(
              value: 0.3,
              color: purple400,
              backgroundColor: neutralColor500,
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          const DashedLineText(
            title: 'Personal Info',
          ),
          const SizedBox(
            height: 16,
          ),
          const NameWidget(),
          const PhoneWidget(),
          const DateofBirthWidget(),
          GenderWidget(),
          const DashedLineText(
            title: 'Address',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            hintText: 'Pincode',
            prefixIcon: Assets.icons.mapPinIcon,
            error: false,
          ),
          CustomTextField(
            hintText: 'Landmark, Locality, Place...',
            prefixIcon: Assets.icons.houseIcon,
            error: false,
          ),
          CustomTextField(
            hintText: 'Flat no., Street name, Area name..',
            prefixIcon: Assets.icons.houseIcon,
            error: false,
          ),
        ]),
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.gender.errorMessage);
    final hasError = context
        .select((PersonalInfoViewModel value) => value.state.gender.hasError);
    return GenderSelector(
      prefixIcon: Assets.icons.genderIcon,
      hintText: 'Gender',
      onChanged: model.changeGender,
      error: hasError,
      errorText: errorMessage,
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.fullName.errorMessage);
    final hasError = context
        .select((PersonalInfoViewModel value) => value.state.fullName.hasError);
    return CustomTextField(
      hintText: 'Name',
      prefixIcon: Assets.icons.userSignIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
    );
  }
}

class DateofBirthWidget extends StatelessWidget {
  const DateofBirthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.dateOfBirth.errorMessage);
    return DatePickerField(
      error: model.state.dateOfBirth.hasError,
      errorText: errorMessage,
      hintText: 'Date of Birth',
      prefixIcon: Assets.icons.calendarIcon,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
      selectedDateFormat: 'dd.MM.yyyy',
      onChanged: model.changeDateOfBirth,
    );
  }
}

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    // ignore: unused_local_variable
    final countryCode = context.select(
      (PersonalInfoViewModel value) => value.state.phoneNumber.countryCode,
    );
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.phoneNumber.errorMessage);
    final hasError = context.select(
        (PersonalInfoViewModel value) => value.state.phoneNumber.hasError);
    return PhoneTextField(
      initialCountryCode: model.state.phoneNumber.countryCode,
      hintText: 'Phone Number',
      error: hasError,
      errorText: errorMessage,
      maxLength: model.state.phoneNumber.maxLength,
      showCounter: true,
      onChanged: (phoneNumber) => model.changePhone(phoneNumber),
      onCountryChanged: (countryCode) => model.setNewCountryCode(countryCode),
    );
  }
}

class PersonalInfoBottom extends StatelessWidget {
  const PersonalInfoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConfirmButton(
          text: 'Save & Continue',
          onPressed: (_) {},
          top: 10,
          bottom: 16,
          left: 32,
          right: 32,
        ),
        SkipTextButton(
          onPressed: () {},
        ),
      ],
    );
  }
}
