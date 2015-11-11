import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: actionDelegate
    width: parent.width
    height: 40

    Rectangle {
        id: hover
        anchors.fill: parent
        color: theme.menuHoverColor
        opacity: 0.2
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

    Image {
        id: actionIcon
        width: parent.height*3/4
        height: width
        fillMode: Image.PreserveAspectFit
        source: icon
        anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 20}

        Colorize {
            anchors.fill: parent
            source: parent
            hue: 0.0
            saturation: 0.5
            lightness: 1.0
            visible: mouseArea.pressed
        }        
    }

    Text {
        id: actionText
        width: parent.width*3/4
        height: parent.height*2/5
        anchors { left: actionIcon.right; verticalCenter: parent.verticalCenter; leftMargin: 10 }
        font.pointSize: parent.height*3/10
        font.bold: false
        verticalAlignment: Text.AlignVCenter
        text: name
        color: mouseArea.pressed? theme.textHighlightColor : theme.textLightColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: { menu.actionClicked(name); sideMenu.hide()}
    }
}
