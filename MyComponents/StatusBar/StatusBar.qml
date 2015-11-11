import QtQuick 2.0

Rectangle {
    id: statusBar

    property alias message: status.text
    height: 40
    gradient: Gradient {
        GradientStop {position: 0; color: theme.gradientStartColor}
        GradientStop {position: 1; color: theme.gradientEndColor}
    }

    Rectangle {
        id: separator

        width: parent.width
        height: 1
        color: "grey"
        anchors {horizontalCenter: parent.horizontalCenter; top: parent.top}
    }

    Text {
        id: status
        width: parent.width
        height: parent.height
        anchors { left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 20 }
        font.pointSize: parent.height/4
        font.bold: false
        verticalAlignment: Text.AlignVCenter
    }
}
