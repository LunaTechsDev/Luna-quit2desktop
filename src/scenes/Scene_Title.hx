package scenes;

import rm.managers.SceneManager;
import utils.Fn;
import core.Types.JsFn;
import rm.scenes.Scene_Title as RmScene_Title;

class Scene_Title {
  public static inline function patch() {
    createCommandwindow();
    onQuit();
  }

  public static inline function createCommandwindow() {
    var oldCreateCommandWindow: JsFn = Fn.getPrProp(RmScene_Title, 'createCommandWindow');
    Fn.setPrProp(RmScene_Title, 'createCommandWindow', () -> {
      var self: RmScene_Title = Fn.self;
      oldCreateCommandWindow.call(self);
      self.__commandWindow.setHandler('quit', untyped self.onQuit.bind(self));
    });
  }

  public static inline function onQuit() {
    Fn.setPrProp(RmScene_Title, 'onQuit', () -> {
      SceneManager.exit();
    });
  }
}
