String endPoint =
    "http://erp-web-apis-env.eba-pbhir2si.ap-southeast-1.elasticbeanstalk.com";

String api = "$endPoint/api";

class ApiEndPoint {
  static String login = "$api/User/Login";
  static String userDetails = "$api/User/GetUserDetails";
  static String passwordReset = "$api/User/Passwordreset";
  static String logout = "$api/User/Logout";
  static String uploadImage = "$api/User/UploadImage";
}
