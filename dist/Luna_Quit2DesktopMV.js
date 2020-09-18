/** ============================================================================
 *
 *  Luna_Quit2DesktopMV
 * 
 *  Build Date: 9/17/2020
 * 
 *  Made with LunaTea -- Haxe
 *
 * =============================================================================
*/
 // Generated by Haxe 4.1.3
/*:
* @plugindesc Adds options to quit directly to desktop in the title or game exit scenes.
* <Luna_Quit2Desktop>
*
* @target MZ MV
* @author LunaTechs | inc0der
* @url https://lunatechs.dev/plugins/luna-quit2desktop/
* 
* @param showOnGameEnd
* @text Show on GameEnd Scene
* @type boolean
* @desc Do you want a quit command on the GameEnd scene?
* @default true
* @on Show
* @off Hide
* 
* @param gameEndText
* @text Game End Command Text
* @type text
* @desc The command text that appears on the GameEnd scene.
* @default To Desktop
* 
* @param gameEndPosition
* @text Game End Command Position
* @type number
* @desc The position of the quit command on the GameEnd scene.
* @default 2
*
* @param showOnTitle
* @text Show on Title Scene
* @type boolean
* @desc Do you want a quit command on the Title scene?
* @default true
* @on Show
* @off Hide
*
* @param titleCommandText
* @text Title Command Text
* @type text
* @desc The command text that appears on the Title scene.
* @default Quit
@help
This plugin allows you to add command to quit to the desktop on the title scene
or on the game end scene.

MIT License
Copyright (c) 2020 LunaTechsDev
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE
* 
*/

(function ($hx_exports, $global) {
  "use strict";
  class Main {
    static main() {
      Main.Params = utils_Parse.parseParameters(
        PluginManager.parameters("Luna_Quit2DesktopMV")
      );
      if (Main.Params.showOnTitle) {
        let oldMakeCommandList = Window_TitleCommand.prototype.makeCommandList;
        Window_TitleCommand.prototype.makeCommandList = function () {
          let self = this;
          oldMakeCommandList.call(self);
          self.addCommand(Main.Params.titleCommandText, "quit", true);
        };
      }

      //=============================================================================
      // Window_GameEnd
      //=============================================================================
      if (Main.Params.showOnGameEnd) {
        let oldMakeCommandList = Window_GameEnd.prototype.makeCommandList;
        Window_GameEnd.prototype.makeCommandList = function () {
          let self = this;
          oldMakeCommandList.call(self);
          self._list.splice(Math.round(Main.Params.gameEndPosition - 1), 0, {
            name: Main.Params.gameEndText,
            symbol: "toDesktop",
            enabled: true,
            ext: null,
          });
        };
      }
      let oldCreateCommandWindow = Scene_Title.prototype.createCommandWindow;
      Scene_Title.prototype.createCommandWindow = function () {
        let self = this;
        oldCreateCommandWindow.call(self);
        self._commandWindow.setHandler("quit", self.onQuit.bind(self));
      };
      Scene_Title.prototype.onQuit = function () {
        SceneManager.exit();
      };

      //=============================================================================
      // Scene_GameEnd
      //=============================================================================
      let oldCreate = Scene_GameEnd.prototype.create;
      Scene_GameEnd.prototype.create = function () {
        let self = this;
        oldCreate.call(self);
        self.createConfirmWindow();
        self.createHelpWindow();
        self._helpWindow.hide();
        return self._helpWindow.close();
      };
      let oldCreateCommandWindow1 = Scene_GameEnd.prototype.createCommandWindow;
      Scene_GameEnd.prototype.createCommandWindow = function () {
        let self = this;
        oldCreateCommandWindow1.call(self);
        self._commandWindow.setHandler(
          "toDesktop",
          self.quit2desktop.bind(self)
        );
      };
      Scene_GameEnd.prototype.createConfirmWindow = function () {
        let self = this;
        let confirmWindow = new Window_$Confirm();
        confirmWindow.x = self._commandWindow.x;
        confirmWindow.y = self._commandWindow.y;
        self._confirmWindow = confirmWindow;
        confirmWindow.setHandler("ok", self.onConfirm.bind(self));
        confirmWindow.close();
        self.addWindow(confirmWindow);
      };
      Scene_GameEnd.prototype.quit2desktop = function () {
        let self = this;
        self._commandWindow.close();
        self._helpWindow.show();
        self._helpWindow.open();
        self._helpWindow.setText("Are you sure you want to exit to desktop?");
        self._confirmWindow.open();
        return self._confirmWindow.activate();
      };
      Scene_GameEnd.prototype.onConfirm = function () {
        let self = this;
        let confirmWindow = self._confirmWindow;
        let choice = confirmWindow.currentSymbol();
        confirmWindow.close();
        if (choice == "yes") {
          SceneManager.exit();
        }
        self._helpWindow.close();
        self._commandWindow.open();
        return self._commandWindow.activate();
      };
    }
  }

  class haxe_iterators_ArrayIterator {
    constructor(array) {
      this.current = 0;
      this.array = array;
    }
    hasNext() {
      return this.current < this.array.length;
    }
    next() {
      return this.array[this.current++];
    }
  }

  class utils_Fn {
    static proto(obj) {
      return obj.prototype;
    }
    static updateProto(obj, fn) {
      return fn(obj.prototype);
    }
    static updateEntity(obj, fn) {
      return fn(obj);
    }
  }

  class utils_Parse {
    static parseParameters(parameters) {
      return (function (string) {
        function superParse(string) {
          var temp;
          try {
            temp = JsonEx.parse(
              typeof string === "object" ? JsonEx.stringify(string) : string
            );
          } catch (e) {
            return string;
          }
          if (typeof temp === "object") {
            Object.keys(temp).forEach(function (key) {
              temp[key] = superParse(temp[key]);
              if (temp[key] === " ") {
                temp[key] = null;
              }
            });
          }
          return temp;
        }
        return superParse(JsonEx.stringify(string));
      })(parameters);
    }
  }

  class Window_$Confirm extends Window_Command {
    constructor() {
      super(0, 0);
    }
    makeCommandList() {
      this.addCommand("Yes", "yes", true);
      this.addCommand("No", "no", true);
    }
  }

  Main.main();
})(
  typeof exports != "undefined"
    ? exports
    : typeof window != "undefined"
    ? window
    : typeof self != "undefined"
    ? self
    : this,
  {}
);
