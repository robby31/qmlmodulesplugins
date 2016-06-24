import QtQuick 2.0

Rectangle {
    id: button
    anchors { verticalCenter: parent.verticalCenter }
    width: textButton.contentWidth*1.2
    height: textButton.contentHeight*1.2
    color: mousearea.pressed? theme.highlightSelectColor : ((mousearea.containsMouse || !hovered)? theme.highlightColor : "transparent")
    border.color: (!hovered || mousearea.containsMouse) ? theme.separatorColor : "transparent"

    radius: 10

    property alias text: textButton.text
    property alias textColor: textButton.color

    property bool hovered: false

    signal buttonClicked()

    Text {
        id: textButton
        anchors.centerIn: parent
        font.pointSize: 12
        clip: true
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: buttonClicked()
    }
}
