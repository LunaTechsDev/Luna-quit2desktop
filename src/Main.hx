import rm.windows.Window_Command;
import utils.Comment;
import rm.managers.SceneManager;
import rm.scenes.Scene_GameEnd;
import rm.core.Rectangle;
import windows.Window_Confirm;
import rm.managers.TextManager;
import rm.windows.Window_GameEnd;
import core.Types.JsFn;
import utils.Fn;

class Main {
  public static function main() {
     /**
      Window_GameEnd
    **/
    Comment.title('Window_GameEnd');
    Fn.setPrProp(Window_GameEnd, 'makeCommandList', () -> {
      var self: Window_GameEnd = Fn.self;
      self.addCommand(TextManager.toTitle, 'toTitle', true);
      self.addCommand('To Desktop', 'toDesktop', true);
      self.addCommand(TextManager.cancel, 'cancel', true);
      trace('added to desktop command');
    });

    Fn.setPrProp(Window_GameEnd, 'maxItems', () -> {
      var self: Dynamic = Fn.self;
      var superMaxItems: JsFn = Fn.getPrProp(Window_Command, 'maxItems');
      return superMaxItems.call(self);
    });

    /**
      Scene_GameEnd
    **/
    Comment.title('Scene_GameEnd');
     var oldCreate: JsFn =  Fn.getPrProp(Scene_GameEnd, 'create');
    Fn.setPrProp(Scene_GameEnd, 'create', () -> {
      var self: Dynamic = Fn.self;
      oldCreate.call(self);
      self.createConfirmWindow();
    });

    var oldCreateCommandWindow: JsFn =  Fn.getPrProp(Scene_GameEnd, 'createCommandWindow');
    Fn.setPrProp(Scene_GameEnd, 'createCommandWindow', () -> {
      var self: Scene_GameEnd = Fn.self;
      oldCreateCommandWindow.call(self);
      self.__commandWindow.setHandler("toDesktop", untyped self.quit2desktop.bind(self));
    });

    Fn.setPrProp(Scene_GameEnd, 'createConfirmWindow', () -> {
      var self: Scene_GameEnd = Fn.self;
      var rect = new Rectangle(
        self.__commandWindow.x,
        self.__commandWindow.y,
        250,
        self.calcWindowHeight(2, true)
      );
      var confirmWindow = new Window_Confirm(rect);
      untyped self._confirmWindow = confirmWindow;
      confirmWindow.setHandler('ok', untyped self.onConfirm.bind(self));
      // confirmWindow.hide();
      confirmWindow.close();
      self.addWindow(confirmWindow);
    });

    Fn.setPrProp(Scene_GameEnd, 'quit2desktop', () -> {
      var self: Dynamic = Fn.self;
      self._confirmWindow.open();
    });

    Fn.setPrProp(Scene_GameEnd, 'onConfirm', () -> {
      var self: Dynamic = Fn.self;
      var confirmWindow: Window_Confirm = self._confirmWindow;
      var choice = confirmWindow.currentSymbol();
      confirmWindow.close();

      if (choice == 'yes') {
        SceneManager.exit();
      }

      self._confirmWindow.activate();
      
    });
  }
}