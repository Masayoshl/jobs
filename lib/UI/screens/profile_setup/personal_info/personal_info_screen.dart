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

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final countryCode = (args?['countryCode'] as String).toUpperCase();
      context.read<PersonalInfoViewModel>().setCountryCode(countryCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final countryCode = (args?['countryCode'] as String).toUpperCase();

    return ScreenBuilder(
      useSliverContent: true,
      overridePhysics: const AlwaysScrollableScrollPhysics(),
      header: const CustomHeader(text: 'Setup your Profile'),
      content: PersonalInfoBody(
        countryCode: countryCode,
      ),
      footer: const PersonalInfoBottom(),
    );
  }
}

class PersonalInfoBody extends StatelessWidget {
  final String countryCode;

  const PersonalInfoBody({
    required this.countryCode,
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
          CustomTextField(
            hintText: 'Name',
            prefixIcon: Assets.icons.userSignIcon,
            error: false,
          ),
          const PhoneWidget(),
          DateofBirthWidget(),
          GenderSelector(
            prefixIcon: Assets.icons.genderIcon,
            hintText: 'Gender',
            error: false,
          ),
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
    final maxLength = context.select(
      (PersonalInfoViewModel value) => value.state.maxLength,
    );
    return PhoneTextField(
      initialCountryCode: model.state.countryCode,
      hintText: 'Phone Number',
      // errorText: 'Invalid Number',
      error: false,
      maxLength: maxLength,
      showCounter: true,
      onChanged: (phoneNumber) {},
      onCountryChanged: (countryCode) => model.setCountryCode(countryCode),
      onCompleted: (value) {},
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
