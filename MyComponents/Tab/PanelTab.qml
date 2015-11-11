import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0

Rectangle {
    id: button

    property string icon: ""
    property string title: ""
    property color textColor: "lightgrey"
    property bool checked: false
    property ExclusiveGroup exclusiveGroup: null

    function activate() {button.checked = true; activated()}
    function deactivate() {button.checked = false; button.deactivated()}

    signal activated
    signal deactivated

    onExclusiveGroupChanged: {
        if (exclusiveGroup)
            exclusiveGroup.bindCheckable(button)
    }

    width: buttonText.contentWidth + buttonIcon.width + 30
    height: 62
    color: "transparent"

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
        visible: button.checked
    }

    Image {
        id: buttonIcon
        width: height
        height: parent.height/2
        anchors {verticalCenter: parent.verticalCenter; left: parent.left; topMargin: parent.height*1/10; leftMargin: parent.height*2/10}
        fillMode: Image.PreserveAspectFit
        source: button.icon

        Colorize {
            anchors.fill: parent
            source: parent
            hue: 0.0
            saturation: 0.0
            lightness: 1.0
            visible: button.pressed || button.checked
        }
    }

    Text {
        id: buttonText
        width: parent.width*3/4
        height: parent.height
        anchors { left: buttonIcon.right; bottom: parent.bottom; leftMargin: parent.height*2/10 }
        font.pointSize: parent.height*3/8*0.6
        font.bold: false
        text: button.title
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        color: (button.pressed || button.checked)? "white" : button.textColor
    }


    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (!button.checked) activate();
            else deactivate();
        }
    }
}
