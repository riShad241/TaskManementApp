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
}