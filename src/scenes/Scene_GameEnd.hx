package scenes;

import rm.managers.SceneManager;
import windows.Window_Confirm;
import rm.core.Rectangle;
import utils.Fn;
import core.Types.JsFn;
import utils.Comment;

import rm.scenes.Scene_GameEnd as RmScene_GameEnd;

class Scene_GameEnd {
  public static inline function patch() {
    Comment.title('Scene_GameEnd');
    create();
    createCommandwindow();
    createConfirmWindow();
    quit2desktop();
    onConfirm();
  }

  public static inline function create() {
    var oldCreate: JsFn = Fn.getPrProp(RmScene_GameEnd, 'create');
    Fn.setPrProp(RmScene_GameEnd, 'create', () -> {
      var self: Dynamic = Fn.self;
      oldCreate.call(self);
      self.createConfirmWindow();
      self.createHelpWindow();
      self._helpWindow.hide();
      self._helpWindow.close();
    });
  }

  public static inline function createCommandwindow() {
    var oldCreateCommandWindow: JsFn = Fn.getPrProp(RmScene_GameEnd, 'createCommandWindow');
    Fn.setPrProp(RmScene_GameEnd, 'createCommandWindow', () -> {
      var self: RmScene_GameEnd = Fn.self;
      oldCreateCommandWindow.call(self);
      self.__commandWindow.setHandler('toDesktop', untyped self.quit2desktop.bind(self));
    });
  }

  public static inline function createConfirmWindow() {
    Fn.setPrProp(RmScene_GameEnd, 'createConfirmWindow', () -> {
      var self: RmScene_GameEnd = Fn.self;
      var rect = new Rectangle(self.__commandWindow.x, self.__commandWindow.y, 250, self.calcWindowHeight(2, true));
      var confirmWindow = new Window_Confirm(rect);
      untyped self._confirmWindow = confirmWindow;
      confirmWindow.setHandler('ok', untyped self.onConfirm.bind(self));
      confirmWindow.close();
      self.addWindow(confirmWindow);
    });
  }

  public static inline function quit2desktop() {
    Fn.setPrProp(RmScene_GameEnd, 'quit2desktop', () -> {
      var self: Dynamic = Fn.self;
      self._helpWindow.show();
      self._helpWindow.open();
      self._helpWindow.setText('Are you sure you want to exit to desktop?');
      self._confirmWindow.open();
    });
  }

  public static inline function onConfirm() {
    Fn.setPrProp(RmScene_GameEnd, 'onConfirm', () -> {
      var self: Dynamic = Fn.self;
      var confirmWindow: Window_Confirm = self._confirmWindow;
      var choice = confirmWindow.currentSymbol();
      confirmWindow.close();

      if (choice == 'yes') {
        SceneManager.exit();
      }

      self._helpWindow.close();
      self._confirmWindow.activate();
    });
  }
}