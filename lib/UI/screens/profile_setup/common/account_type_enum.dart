import 'package:jobs/UI/screens/profile_setup/account_type/widgets/type_selector.dart';
import 'package:jobs/gen/assets.gen.dart';

enum AccountType implements TypeSelectorEnum {
  employee,
  company;

  @override
  String get title => switch (this) {
        AccountType.employee => 'Employee',
        AccountType.company => 'Company',
      };
  @override
  String get subtitle => switch (this) {
        AccountType.company => 'for an employee search',
        AccountType.employee => 'for a job search'
      };
  @override
  String get icon => switch (this) {
        AccountType.company => Assets.images.accountTypeCompanyType,
        AccountType.employee => Assets.images.accountTypeEmployeeType,
      };
}
