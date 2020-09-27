
import rm.managers.PluginManager;
import windows.Window_TitleCommand;
import windows.Window_GameEnd;
import scenes.Scene_Title;
import scenes.Scene_GameEnd;
import rm.scenes.Scene_Title as RmScene_Title;
import rm.scenes.Scene_GameEnd as RmScene_GameEnd;
import rm.windows.Window_GameEnd as RmWindow_GameEnd;
import rm.windows.Window_TitleCommand as RmWindow_TitleCommand;
import utils.Parse.parseParameters;

class Main {
  public static var Params: Dynamic;
  
  public static function main() {
    #if compileMV
    var rawParams = PluginManager.parameters('Luna_Quit2DesktopMV');
    #else
    var rawParams = PluginManager.parameters('Luna_Quit2Desktop');
    #end
    Params = parseParameters(rawParams);

    utils.Comment.title('Window_TitleCommand');
    macros.FnMacros.jsPatch(true, RmWindow_TitleCommand, Window_TitleCommand);
    utils.Comment.title('Scene_Title');
    macros.FnMacros.jsPatch(true, RmScene_Title, Scene_Title);
    utils.Comment.title('Scene_GameEnd');
    macros.FnMacros.jsPatch(true, RmScene_GameEnd, Scene_GameEnd);
    utils.Comment.title('Window_GameEnd');
    macros.FnMacros.jsPatch(true, RmWindow_GameEnd, Window_GameEnd);
  }
}
