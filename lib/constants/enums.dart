enum Module {
  backgroundColor,
  fontColor,
  fontSize,
  fontFamily,
  margins,
  name,
}

enum SortType {
  author,
  title,
}

enum Direction {
  up,
  down,
}

enum LoginResult {
  success,
  invalidUsername,
  invalidPassword,
  unknownError,
}

enum RegistrationResult {
  success,
  missingUsername,
  invalidEmail,
  usedUsername,
  missingPassword,
  missingReenter,
  invalidPassword,
  passwordMismatch,
  unknownError,
}
