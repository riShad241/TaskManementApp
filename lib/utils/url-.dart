class Urls {
  Urls._();
  static const String baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = "$baseUrl/registration";
  static String login = "$baseUrl/login";
  static String createTask = '$baseUrl/createTask';
  static String taskStatusCount = '$baseUrl/taskStatuscount';
  static String newTasks = '$baseUrl/listTaskByStatus/New';
  static String progressTasks = '$baseUrl/listTaskByStatus/Progress';
  static String cancelledTasks = '$baseUrl/listTaskByStatus/Cancelled';
  static String completedTask = '$baseUrl/listTaskByStatus/Completed';
  static String deleteTask(String id) => '$baseUrl/deleteTask/$id';
  static String updateTask(String id, String status) =>
      '$baseUrl/updateTaskStatus/$id/$status';

  static String updateProfile = '$baseUrl/profileUpdate';
  static String sendOtpToEmail(String email) => '$baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) => '$baseUrl/RecoverVerifyOTP/$email/$otp';
  static String resetPassword = '$baseUrl/RecoverResetPass';
  static String recoveryEmailUrl = '$baseUrl/RecoverVerifyEmail/'; //email address
  static String recoveryOTPUrl = '$baseUrl/RecoverVerifyOTP/'; //email address // otp
  static String setPasswordUrl = '$baseUrl/RecoverResetPass';

  static String profileUpdateUrl = '$baseUrl/profileUpdate';
}