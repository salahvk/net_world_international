String endPoint = "http://erpapp.ap-southeast-1.elasticbeanstalk.com";

String api = "$endPoint/api";

class ApiEndPoint {
  static String login = "$api/User/Login";
  static String userDetails = "$api/User/GetUserDetails";
  static String passwordReset = "$api/User/Passwordreset";
  static String logout = "$api/User/Logout";
  static String uploadImage = "$api/User/UploadImage";
  static String getItemConfig = "$api/Item/GetConfig";
  static String getItems = "$api/Item/Getitems";
  static String addItems = "$api/Item/addItem";
  static String getNextItem = "$api/Item/GetNextItem";
}
