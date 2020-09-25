package scenes;

import rm.managers.SceneManager;
import windows.Window_Confirm;
import rm.core.Rectangle;
import rm.scenes.Scene_GameEnd as RmScene_GameEnd;

class Scene_GameEnd extends RmScene_GameEnd {
  public override function create() {
    untyped _Scene_GameEn_prototype_create.call(self);
    this.createConfirmWindow();
    this.createHelpWindow();
    this._helpWindow.hide();
    this._helpWindow.close();
  }

  public override function createCommandWindow() {
    untyped _Scene_GameEnd_prototype_createCommandWindow.call(self);
    this.__commandWindow.setHandler('toDesktop', untyped self.quit2desktop.bind(self));
  }

  public function createConfirmWindow() {
    #if compileMV
    var confirmWindow = new Window_Confirm();
    confirmWindow.x = this._commandWindow.x;
    confirmWindow.y = this._commandWindow.y;
    #else
    var rect = new Rectangle(this._commandWindow.x, this._commandWindow.y, 250, this.calcWindowHeight(2, true));
    var confirmWindow = new Window_Confirm(rect);
    #end
    untyped this._confirmWindow = confirmWindow;
    confirmWindow.setHandler('ok', untyped this.onConfirm);
    confirmWindow.close();
    this.addWindow(confirmWindow);
  }

  public function quit2desktop() {
    this._commandWindow.close();
    this._helpWindow.show();
    this._helpWindow.open();
    this._helpWindow.setText('Are you sure you want to exit to desktop?');
    untyped this._confirmWindow.open();
    untyped this._confirmWindow.activate();
  }

  public function onConfirm() {
    var confirmWindow: Window_Confirm = untyped this._confirmWindow;
    var choice = confirmWindow.currentSymbol();
    confirmWindow.close();

    if (choice == 'yes') {
      SceneManager.exit();
    }

    this._helpWindow.close();
    this._commandWindow.open();
    this._commandWindow.activate();
  }
}
