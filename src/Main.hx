
import rm.managers.PluginManager;
import windows.Window_TitleCommand;
import windows.Window_GameEnd;
import scenes.Scene_Title;
import scenes.Scene_GameEnd;
import utils.Parse.parseParameters;

class Main {
  public static var Params: Dynamic;
  
  public static function main() {
    var rawParams = PluginManager.parameters('Luna_Quit2Desktop');
    Params = parseParameters(rawParams);

    Window_TitleCommand.patch();
    Window_GameEnd.patch();
    Scene_Title.patch();
    Scene_GameEnd.patch();
  }
}
