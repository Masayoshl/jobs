import 'package:flutter/material.dart';

import 'package:jobs/UI/screens/profile_setup/personal_info/personal_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/widgets.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/dashed_line_text.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/skip_text_button.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/text_field/description_text_field.dart';

import 'package:jobs/UI/widgets/widgets.dart';

import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isLoading = context.select(
        (PersonalInfoViewModel vm) => vm.isLoading,
      );

      if (isLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return const ScreenBuilder(
        useSliverContent: true,
        overridePhysics: AlwaysScrollableScrollPhysics(),
        header: CustomHeader(text: 'Setup your Profile'),
        content: PersonalInfoBody(),
        footer: PersonalInfoBottom(),
      );
    });
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
          const DashedLineText(title: 'Personal Info'),
          const NameWidget(hintText: 'Full Name'),
          const PhoneWidget(),
          const DateofBirthWidget(),
          const GenderWidget(),
          const DashedLineText(title: 'Location (optional)'),
          const CityFieldWidget(),
          const AddressFieldWidget(),
        ]),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  const NameWidget({
    super.key,
    required this.hintText,
  });
  final String hintText;
  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.fullName.errorMessage);
    final hasError = context
        .select((PersonalInfoViewModel value) => value.state.fullName.hasError);
    return CustomTextField(
      hintText: hintText,
      prefixIcon: Assets.icons.userSignIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
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

class AddressFieldWidget extends StatelessWidget {
  const AddressFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    return CustomTextField(
      hintText: 'Address',
      prefixIcon: Assets.icons.building3Icon,
      error: false,
      onChanged: model.changeAddress,
    );
  }
}

class CityFieldWidget extends StatelessWidget {
  const CityFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    return CustomTextField(
      hintText: 'City',
      prefixIcon: Assets.icons.building02Icon,
      error: false,
      onChanged: model.changeCity,
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    final errorMessage = context.select(
        (PersonalInfoViewModel value) => value.state.fullName.errorMessage);
    final hasError = context
        .select((PersonalInfoViewModel value) => value.state.fullName.hasError);
    return DescriptionTextField(
      hintText: 'Description',
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
    );
  }
}

class WebsiteWidget extends StatelessWidget {
  const WebsiteWidget({
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
      hintText: 'Website',
      prefixIcon: Assets.icons.workIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
    );
  }
}

class IndustryWidget extends StatelessWidget {
  const IndustryWidget({
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
      hintText: 'Industry',
      prefixIcon: Assets.icons.workIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
    );
  }
}

class ContactEmailWidget extends StatelessWidget {
  const ContactEmailWidget({
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
      hintText: 'Contact email',
      prefixIcon: Assets.icons.mailIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeName,
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
