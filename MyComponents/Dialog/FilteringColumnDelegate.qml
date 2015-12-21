import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: delegate
    width: parent.width;
    height: 20

    Rectangle {
        id: hover
        anchors.fill: parent
        color: theme.hoverColor
        visible: mouseArea.containsMouse
    }

    Rectangle {
        id: highlight
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: theme.highlightGradientStart }
            GradientStop { position: 1.0; color: theme.highlightGradientEnd }
        }
        visible: mouseArea.pressed
    }

    Text {
        id: columnName
        anchors {left: parent.left; top: parent.top; leftMargin: 20; topMargin: (delegate.height-height)/5}
        font.pixelSize: 12
        color: (used) ? "blue" : (mouseArea.pressed ? theme.textHighlightColor : theme.textColor)
        text: name
    }

    Rectangle {
        id: separatorBottom
        width: parent.width
        height: 1
        anchors {left: parent.left; bottom: parent.bottom}
        color: theme.separatorColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: delegate.ListView.view.currentIndex = index
    }
}
