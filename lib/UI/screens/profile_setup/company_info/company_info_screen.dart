import 'package:flutter/material.dart';
import 'package:jobs/UI/screens/profile_setup/company_info/company_info_view_model.dart';
import 'package:jobs/UI/screens/profile_setup/company_info/widgets/industry_field.dart';

import 'package:jobs/UI/screens/profile_setup/personal_info/widgets/phone_text_field.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/dashed_line_text.dart';
import 'package:jobs/UI/screens/profile_setup/widgets/skip_text_button.dart';
import 'package:jobs/UI/theme/theme.dart';
import 'package:jobs/UI/widgets/text_field/description_text_field.dart';
import 'package:jobs/gen/assets.gen.dart';
import 'package:provider/provider.dart';

import '../../../widgets/screen_builder/screen_builder.dart';
import '../../../widgets/widgets.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenBuilder(
      useSliverContent: true,
      overridePhysics: AlwaysScrollableScrollPhysics(),
      header: CustomHeader(text: 'Setup your Profile'),
      content: CompanyInfoBody(),
      footer: CompanyInfoBottom(),
    );
  }
}

class CompanyInfoBody extends StatelessWidget {
  const CompanyInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CompanyInfoViewModel>(builder: (context, model, _) {
      final state = model.state;

      if (state.isLoading) {
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (state.errorMessage != null) {
        return SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.textXLSemibold,
                ),
              ),
              ElevatedButton(
                onPressed: () => model.onButtonPressed(context),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      if (!state.isLoading && state.errorMessage == null) {
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
              const DashedLineText(title: 'Company Info'),
              //
              const NameWidget(hintText: 'Company Name'),
              const ContactEmailWidget(),
              const PhoneWidget(),
              const IndustryWidget(),
              const WebsiteWidget(),
              const DescriptionWidget(),
              //
              const DashedLineText(title: 'Location (optional)'),
              const CityFieldWidget(),
              const AddressFieldWidget(),
            ]),
          ),
        );
      }
      return const SliverFillRemaining();
    });
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
    final model = context.read<CompanyInfoViewModel>();
    final errorMessage = context
        .select((CompanyInfoViewModel value) => value.state.name.errorMessage);
    final hasError = context
        .select((CompanyInfoViewModel value) => value.state.name.hasError);
    return CustomTextField(
      hintText: hintText,
      prefixIcon: Assets.icons.userSignIcon,
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
    final model = context.read<CompanyInfoViewModel>();
    final errorMessage = context.select(
        (CompanyInfoViewModel value) => value.state.contactEmail.errorMessage);
    final hasError = context.select(
        (CompanyInfoViewModel value) => value.state.contactEmail.hasError);
    return CustomTextField(
      hintText: 'Contact email',
      prefixIcon: Assets.icons.mailIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeEmail,
    );
  }
}

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    // ignore: unused_local_variable
    final countryCode = context.select(
      (CompanyInfoViewModel value) => value.state.phoneNumber.countryCode,
    );
    final errorMessage = context.select(
        (CompanyInfoViewModel value) => value.state.phoneNumber.errorMessage);
    final hasError = context.select(
        (CompanyInfoViewModel value) => value.state.phoneNumber.hasError);
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

class WebsiteWidget extends StatelessWidget {
  const WebsiteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    final errorMessage = context.select(
        (CompanyInfoViewModel value) => value.state.website.errorMessage);
    final hasError = context
        .select((CompanyInfoViewModel value) => value.state.website.hasError);
    return CustomTextField(
      hintText: 'Website',
      prefixIcon: Assets.icons.globalIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeWebsite,
    );
  }
}

class IndustryWidget extends StatelessWidget {
  const IndustryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    final errorMessage = context.select(
        (CompanyInfoViewModel value) => value.state.industry.errorMessage);
    final hasError = context
        .select((CompanyInfoViewModel value) => value.state.industry.hasError);
    return IndustryField(
      hintText: 'Industry',
      prefixIcon: Assets.icons.workIcon,
      error: hasError,
      errorText: errorMessage,
      onChanged: (value) => model.changeIndustry(value),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    final errorMessage = context.select(
        (CompanyInfoViewModel value) => value.state.description.errorMessage);
    final hasError = context.select(
        (CompanyInfoViewModel value) => value.state.description.hasError);
    return DescriptionTextField(
      hintText: 'Description',
      error: hasError,
      errorText: errorMessage,
      onChanged: model.changeDescription,
    );
  }
}

class CityFieldWidget extends StatelessWidget {
  const CityFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    return CustomTextField(
      hintText: 'City',
      prefixIcon: Assets.icons.building02Icon,
      error: false,
      onChanged: model.changeCity,
    );
  }
}

class AddressFieldWidget extends StatelessWidget {
  const AddressFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    return CustomTextField(
      hintText: 'Address',
      prefixIcon: Assets.icons.building3Icon,
      error: false,
      onChanged: model.changeAddress,
    );
  }
}

class CompanyInfoBottom extends StatelessWidget {
  const CompanyInfoBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<CompanyInfoViewModel>();
    final buttonState =
        context.select((CompanyInfoViewModel value) => value.state.buttonState);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConfirmButton(
          state: buttonState,
          text: 'Save & Continue',
          onPressed: (context) => model.onButtonPressed(context),
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
