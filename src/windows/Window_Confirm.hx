package windows;

import rm.windows.Window_Command;
import rm.core.Rectangle;

@:native('Window_Confirm')
class Window_Confirm extends Window_Command {
  #if compileMV
  public function new() {
    super(0, 0);
  }
  #else
  public function new(rect: Rectangle) {
    super(0, 0);
    super(rect);
  }
  #end

  public override function refresh() {
    super.refresh();
  }

  public override function makeCommandList() {
    addCommand('Yes', 'yes', true);
    addCommand('No', 'no', true);
  }
}
