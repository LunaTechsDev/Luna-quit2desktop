package windows;

import Main.Params;
import rm.windows.Window_TitleCommand as RmTitleCommand;

using Lambda;

class Window_TitleCommand extends RmTitleCommand {
  public override function makeCommandList() {
    untyped Window_TitleCommand_prototype_makeCommandList.call(this);
    this.addCommand(Params.titleCommandText, 'quit', true);
  }
}
