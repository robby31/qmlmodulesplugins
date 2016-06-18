import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: button
    property alias iconSource: buttonIcon.source
    property alias text: buttonText.text
    property bool active: true
    property color textColor: theme.separatorLightColor

    signal clicked()

    width: 100
    height: 100

    Rectangle {
        id: hover
        anchors.fill: parent
        color: theme.menuHoverColor
        opacity: 0.2
        visible: active && mouseArea.containsMouse
    }

    Rectangle {
        id: highlight
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: theme.highlightGradientStart }
            GradientStop { position: 1.0; color: theme.highlightGradientEnd }
        }
        visible: active && mouseArea.pressed
    }

    Image {
        id: buttonIcon
        width: parent.width*3/4
        height: parent.height*5/10
        anchors {top: parent.top; horizontalCenter: parent.horizontalCenter; topMargin: parent.height*1/10}
        fillMode: Image.PreserveAspectFit
    }

    Colorize {
        anchors.fill: buttonIcon
        source: buttonIcon
        hue: 0.0
        saturation: 0.5
        lightness: 1.0
        visible: mouseArea.pressed
    }

    Text {
        id: buttonText
        width: parent.width*3/4
        height: button.iconSource == "" ? parent.height : parent.height*2/5
        anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
        font.pointSize: button.iconSource == "" ? parent.height*3/4*0.35 : parent.height*3/4*0.2
        font.bold: false
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: mouseArea.pressed? theme.lightColor : button.textColor
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: button.active
        onClicked: button.clicked()
    }
}
