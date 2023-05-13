import 'package:net_world_international/core/controllers/controllers.dart';
import 'package:transliteration/response/transliteration_response.dart';
import 'package:transliteration/transliteration.dart';

transiletrate() async {
  TransliterationResponse? response = await Transliteration.transliterate(
      ItemMasterControllers.nameController.text, Languages.ARABIC);
  ItemMasterControllers.arabicController.text =
      response!.transliterationSuggestions[0].toString();
}
