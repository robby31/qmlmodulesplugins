import QtQuick 2.0
import MyComponents 1.0

Item {
    id: popupBox

    property alias text: message.text
    property int popupType: POP_INFO
    property bool pop: true

    signal closeTriggered()

    onPopupTypeChanged: {
        if (popupType == 0)
        {
            box.colorStart = theme.popupInfoGradientStart;
            box.colorEnd   = theme.popupInfoGradientEnd;
        }
        else if (popupType == 1)
        {
            box.colorStart = theme.popupWarningGradientStart;
            box.colorEnd   = theme.popupWarningGradientEnd;
        }
        else if (popupType == 2)
        {
            box.colorStart = theme.popupErrorGradientStart;
            box.colorEnd   = theme.popupErrorGradientEnd;
        }
    }

    width: 200
    height: 62

    Rectangle {
        id: box

        property color colorStart: theme.popupInfoGradientStart
        property color colorEnd: theme.popupInfoGradientEnd

        width: message.width+20
        height: message.height+20
        anchors {horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: -box.height-20}
        radius: 5
        gradient: Gradient {
            GradientStop { position: 0.0; color: box.colorStart }
            GradientStop { position: 1.0; color: box.colorEnd }
        }

        Rectangle {
            id: closeButtonArea
            width: 20
            height: width
            radius: width/2
            x: box.width-width/2
            y: -height/2
            color: mouseArea.pressed ? theme.highlightGradientStart : "black"
            border.color: "white"

            Image {
                id: closeButton
                width: parent.width/2
                height: parent.height/2
                anchors.centerIn: parent
                source: "../Image/close.png"
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: popupBox.closeTriggered()
            }
        }

        Text {
            id: message
            width: contentWidth
            height: contentHeight
            anchors.centerIn: parent
            font.pointSize: 12
            font.bold: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: "white"
            wrapMode: Text.WordWrap
            onTextChanged: {
                var lineWidth = message.text.length*message.font.pointSize*2/3
                message.width = (lineWidth <= popupBox.width-40) ? lineWidth : popupBox.width-40;
            }
        }
    }
    states: [
        State {
            name: "VISIBLE"
            PropertyChanges { target: box; anchors.topMargin: 80}
            when: pop
        }
    ]
    transitions: [
        Transition {
            NumberAnimation {duration: 300; properties: "anchors.topMargin"}
        }
    ]
}
