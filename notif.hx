import haxe.io.Input;
import funkin.backend.utils.NdllUtil;
import sys.FileSystem;
import Sys;

var notifSend = NdllUtil.getFunction("notification", "notification_send", 3);
var notifDelete = NdllUtil.getFunction("notification", "notification_delete", 0);
function sendNotif(title:String, desc:String, taskIconPath:String) {
    //the taskbar icon argument only accepts .ico files, sorry!!
    var args:Array<String>;

    #if windows //FOR WINDOWS
    notifSend(title, desc, FileSystem.absolutePath(taskIconPath));
    #elseif mac //FOR MAC
    notifSend(title, desc, FileSystem.absolutePath(taskIconPath));
    #elseif linux //FOR LINUX
    args = ["-u", "normal", title, desc]
    Sys.command("notify-send", args);
    #end
}

function create() {
    #if windows
    sendNotif("current song:", PlayState.SONG.meta.displayName + " - " + PlayState.difficulty, "icon.ico");
    window.onClose.add(function() {
        notifDelete();
    }); //Deletes the notification(s) after the window closes
    #end
}