package windows;

import utils.Fn;
import Main.Params;
import core.Types.JsFn;
import rm.windows.Window_TitleCommand as RmTitleCommand;

using Lambda;

class Window_TitleCommand {
  public static inline function patch() {
    if (Params.showOnTitle) {
      makeCommandList();
    }
  }

  public static inline function makeCommandList() {
    var oldMakeCommandList: JsFn = Fn.getPrProp(RmTitleCommand, 'makeCommandList');
    Fn.setPrProp(RmTitleCommand, 'makeCommandList', () -> {
      var self: RmTitleCommand = Fn.self;
      oldMakeCommandList.call(self);
      self.addCommand(Params.titleCommandText, 'quit', true);
    });
  }
}
