package windows;

import rm.windows.Window_Command;
import Main.Params;
import rm.windows.Window_GameEnd as RmWindow_GameEnd;

class Window_GameEnd extends RmWindow_GameEnd {
  public override function makeCommandList() {
    untyped _Winodw_GameEnd_prototype_makeCommandList.call(this);
    var index: Int = Math.round(Params.gameEndPosition - 1);
    this._list.insert(index, {
      name: Params.gameEndText,
      symbol: 'toDesktop',
      enabled: true,
      ext: null
    });
  }

  public override function maxItems() {
    return untyped Window_Command.prototype.maxItem.call(this);
  }
}
