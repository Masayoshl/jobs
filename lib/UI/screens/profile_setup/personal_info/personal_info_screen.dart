import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/personal_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/date_picker_field.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/gender_selector_field.dart';
import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/phone_text_field.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/dashed_line_text.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/confirm_button.dart';
import 'package:jobs/UI/widgets/custom_header.dart';
import 'package:jobs/UI/widgets/screen_builder/screen_builder.dart';
import 'package:jobs/UI/widgets/text_field/custom_text_field.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final countryCode = (args?['countryCode'] as String).toUpperCase();
    //todo перепиши эту хуйню
    context.read<PersonalInfoViewModel>().setCountryCode(countryCode);
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
          PhoneWidget(),
          DatePickerField(
            error: false,
            hintText: 'Date of Birth',
            prefixIcon: Assets.icons.calendarIcon,
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            initialDate: DateTime(2000),
            selectedDateFormat: 'dd.MM.yyyy',
            onChanged: (String date) {
              // Обработка выбранной даты
            },
          ),
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

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<PersonalInfoViewModel>();
    return PhoneTextField(
      initialCountryCode: model.state.countryCode,
      hintText: 'Phone Number',
      // errorText: 'Invalid Number',
      error: false,
      maxLength: model.state.maxLength,
      showCounter: true,
      onChanged: (phoneNumber) {},
      onCountryChanged: (countryCode) {},
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
          bottom: 32,
          left: 32,
          right: 32,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Skip For Now',
                style: AppTextStyles.textXXLSemibold.copyWith(color: purple400),
                recognizer: TapGestureRecognizer()..onTap = () {},
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }
}
