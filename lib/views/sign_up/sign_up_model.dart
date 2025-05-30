// Country Code Model
class CountryCode {
  final String name;
  final String code;
  final String dialCode;
  final RegExp phoneValidation; // Validation Pattern

  CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.phoneValidation,
  });
}