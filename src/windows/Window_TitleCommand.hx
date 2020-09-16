package windows;

import utils.Fn;
import core.Types.JsFn;
import rm.windows.Window_TitleCommand as RmTitleCommand;

using Lambda;

class Window_TitleCommand {
  public static inline function patch() {
    makeCommandList();
  }

  public static inline function makeCommandList() {
    var oldMakeCommandList: JsFn = Fn.getPrProp(RmTitleCommand, 'makeCommandList');
    Fn.setPrProp(RmTitleCommand, 'makeCommandList', () -> {
      var self: RmTitleCommand = Fn.self;
      oldMakeCommandList.call(self);
      self.addCommand('Quit', 'quit', true);
    });
  }
}
