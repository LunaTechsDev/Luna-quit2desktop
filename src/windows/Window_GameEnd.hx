package windows;

import rm.windows.Window_Command;
import core.Types.JsFn;
import utils.Fn;
import Main.Params;
import rm.windows.Window_GameEnd as RM_Window_GameEnd;

class Window_GameEnd {
  public static inline function patch() {
    utils.Comment.title('Window_GameEnd');
    if (Params.showOnGameEnd) {
      makeCommandList();
    }
  }

  public static inline function makeCommandList() {
    var oldMakeCommandList: JsFn = Fn.getPrProp(RM_Window_GameEnd, 'makeCommandList');
    Fn.setPrProp(RM_Window_GameEnd, 'makeCommandList', () -> {
      var self: RM_Window_GameEnd = Fn.self;
      oldMakeCommandList.call(self);
      self.__list.insert(1, {
        name: Params.gameEndText,
        symbol: 'toDesktop',
        enabled: true,
        ext: null
      });
    });
  }

  public static inline function maxItems() {
    Fn.setPrProp(Window_GameEnd, 'maxItems', () -> {
      var self: Dynamic = Fn.self;
      var superMaxItems: JsFn = Fn.getPrProp(Window_Command, 'maxItems');
      return superMaxItems.call(self);
    });
  }
}
