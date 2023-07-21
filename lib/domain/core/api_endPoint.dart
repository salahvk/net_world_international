String api = "/api";

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
  static String addAlterItems = "$api/Item/AddItemsinAlterUnit";
  static String getItemById = "$api/Item/";
  static String itemUpdateById = "$api/Item/UpdateItem/";
  static String itemByBarcode = "$api/Item/barcode/";
  static String genBarcode = "$api/Item/generateBarcode?StarChar=1&MaxId=1";
  static String genAlternateBarcode =
      "$api/Item/genAlternateBarcode?AltBarcodeStartChar=5&MaxId=1";
}
