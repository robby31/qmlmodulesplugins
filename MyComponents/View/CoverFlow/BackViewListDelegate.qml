import QtQuick 2.0
import QtGraphicalEffects 1.0
import MyComponents 1.0

Item {
    id: delegate
    width: parent.width;
    height: 50
    clip: true

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
        id: titleName
        anchors {left: parent.left; top: parent.top; leftMargin: 20; topMargin: (delegate.height-height)/5}
        font.pixelSize: 16
        color: mouseArea.pressed ? theme.textHighlightColor : theme.textColor
        text: name
    }
    Text {
        id: descriptionText
        anchors {left: parent.left; top: titleName.bottom; leftMargin: 20; topMargin: 4}
        font.pixelSize: 12
        color: mouseArea.pressed ? theme.textHighlightColor : theme.titleColor
        text: description
    }
    Image {
        id: arrow
        source: "Image/arrow.png"
        height: parent.height/2
        width: height
        anchors {verticalCenter: parent.verticalCenter; right: parent.right; rightMargin: 10}

        Colorize {
            anchors.fill: parent
            source: parent
            hue: 0.0
            saturation: 0.5
            lightness: 1.0
            visible: mouseArea.pressed
        }
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
        onClicked: {dataViewList.selectedBackItem(id)}
    }
}
