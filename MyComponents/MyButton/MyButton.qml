import QtQuick 2.0

Rectangle {
    id: button
    anchors { verticalCenter: parent.verticalCenter }
    width: loader.width*1.2
    height: loader.height*1.2
    color: mousearea.pressed? theme.highlightSelectColor : ((mousearea.containsMouse || !hovered)? theme.highlightColor : "transparent")
    border.color: (!hovered || mousearea.containsMouse) ? theme.separatorColor : "transparent"

    radius: 10

    property alias source: loader.source
    property alias sourceComponent: loader.sourceComponent

    property bool hovered: false

    signal buttonClicked()

    Loader {
        id: loader
        anchors { verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: buttonClicked()
    }
}
