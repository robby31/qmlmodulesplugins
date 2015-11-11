import QtQuick 2.0

Item {
    id: scrollIndicator

    property alias handleSize: handle.height
    property alias handlePosition: handle.y

    width: 10
    height: 60
    Behavior on opacity {NumberAnimation {duration: 500}}

    Rectangle {
        id: ribbon
        anchors.fill: parent
        color: "black"
        opacity: 0.4
    }

    Rectangle {
        id: handle
        width: parent.width
        color: theme.headerBackgroundColor
    }
}
