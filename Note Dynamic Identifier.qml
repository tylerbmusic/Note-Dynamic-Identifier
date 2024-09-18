import QtQuick 2.1
import QtQuick.Controls 2.15
import MuseScore 3.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.15
MuseScore {
    menuPath: "Plugins.Note Dynamic Identifier"
    version: "1.1"
    description: "Tells you what the last dynamic of the part you have selected is. Note: For the plugin to work properly, first select a measure or multiple notes. If you don't see a box around your selection, the plugin won't work."
    title: "Note Dynamic Identifier"
    requiresScore: true
    categoryCode: "composing-arranging-tools"
    thumbnailName: "identifier.png"
    id: waoejif
    onRun: {
        waoejif.visible = false;
        if (typeof curScore === 'undefined') return;
        var cursor = curScore.newCursor();
        cursor.rewind(1);
        var firstTick = cursor.tick;
        cursor.rewind(0);
        var fT = "";
        while (cursor.segment && cursor.tick < firstTick) {
            var annotations = cursor.segment.annotations;
            for (var i = 0; i < annotations.length; i++) {
                if ((annotations[i].staff.part.startTrack / 4) == cursor.staffIdx) {
                console.log(annotations[i].staff.part.startTrack / 4);
                if (annotations[i].text.indexOf("dynamic") >= 0) {
                    var a = annotations[i].text.split("<sym>dynamic");
                    for (var j = 1; j < a.length; j++) {
                        if (a[j].indexOf("</sym>") >= 0) {
                            a[j] = a[j].substr(0, a[j].indexOf("</sym>"));
                        }
                    }
                    a.shift();
                    fT = "";
                    for (var k = 0; k < a.length; k++) {
                        fT += a[k] + " ";
                        }
                    }
                }
            }
            cursor.next();
        }
        box.text = fT;
        box.open();
    }
    //UI
    MessageDialog {
        id: box
        text: "Nope!"
        title: "Volume Identifier"
    }
}
