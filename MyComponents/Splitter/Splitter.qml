import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0


SplitView {
    id: splitter
    property alias topItem: topItemLoader.sourceComponent
    property alias bottomItem: bottomItemLoader.sourceComponent

    property Item view: topItemLoader.item
    property Item feature: bottomItemLoader.item

    function deploy() {
        bottomItemLoader.Layout.minimumHeight = 40
        state = "OPEN"
    }
    function collapse() {
        bottomItemLoader.Layout.minimumHeight = 0
        state = "CLOSED"
    }

    state: "CLOSED"
    width: 100
    height: 62
    anchors {left: parent.left; top: separator.bottom; right: parent.right; bottom: statusBar.top}
    orientation: Qt.Vertical

    Loader {
        id: topItemLoader
        width: parent.width
        Layout.fillHeight: true
    }
    Loader {
        id: bottomItemLoader
        width: parent.width
    }

    handleDelegate: Rectangle {height: 1}//; color: "black"}

    states: [
        State {
            name: "OPEN"
            PropertyChanges { target: bottomItemLoader; height: splitter.height/2}
        },
        State {
            name: "CLOSED"
            PropertyChanges { target: bottomItemLoader; height: 0}
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {properties: "height"; easing.type: Easing.InOutQuad; duration: 150}
        }
    ]
}
