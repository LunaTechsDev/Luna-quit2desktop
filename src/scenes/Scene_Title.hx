package scenes;

import rm.managers.SceneManager;
import rm.scenes.Scene_Title as RmScene_Title;

class Scene_Title extends RmScene_Title {
  public override function createCommandWindow() {
    untyped _Scene_Title_createCommandWindow.call(this);
    this._commandWindow.setHandler('quit', untyped this.onQuit);
  }

  public function onQuit() {
    SceneManager.exit();
  }
}
