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

enum Position {
  top,
  right,
  bottom,
  left,
}
enum LoginResult {
  success,
  disabled,
  invalidEmail,
  wrongPassword,
  weakPassword,
  missingEmail,
  missingPassword,
  missingReenter,
  passwordMismatch,
  notFound,
  usedUsername,
  brute,
  unknownError,
}

enum LoadingStatus {
  working,
  ready,
}
