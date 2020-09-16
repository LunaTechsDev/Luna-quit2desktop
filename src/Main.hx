
import windows.Window_TitleCommand;
import windows.Window_GameEnd;
import scenes.Scene_Title;
import scenes.Scene_GameEnd;

class Main {
  public static function main() {
    Window_TitleCommand.patch();
    Window_GameEnd.patch();
    Scene_Title.patch();
    Scene_GameEnd.patch();
  }
}
