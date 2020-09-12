abstract class PersonalDiaryException implements Exception {}

class NoInternetException implements PersonalDiaryException {}

class GenericException implements PersonalDiaryException {}

class UnexpectedException implements PersonalDiaryException {}

class InvalidCredentialsException implements PersonalDiaryException {}

abstract class FormFieldException implements PersonalDiaryException {}

class EmptyFormFieldException implements FormFieldException {}

class InvalidFormFieldException implements FormFieldException {}
