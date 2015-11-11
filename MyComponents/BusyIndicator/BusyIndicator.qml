import QtQuick 2.0
import MyComponents 1.0

Item {
    id: busyIndicator
    signal cancel

    property string activity: ""//activityText.text
    property int activityProgress: -1// indicator.value
    property alias logo: indicator.logo

    onVisibleChanged: {if (busyIndicator.visible) busyIndicator.state = "RUNNING"}

    state: "RUNNING"

    width: 1000
    height: 600

    Rectangle {
        anchors.fill: parent
        color: theme.darkColor
        opacity: 0.4

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            preventStealing: true
        }
    }
    Item {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        ProgressCircle {
            id: indicator
            width: 80
            height: 80
            size: 80
            anchors.centerIn: parent
            color: theme.highlightGradientStart
            value: busyIndicator.state == "RUNNING" ? busyIndicator.activityProgress : -1

            onValueChanged: update()
        }
        Rectangle {
            id: textRec
            width: activityText.width+20
            height: activityText.height+10
            anchors.centerIn: activityText
            radius: 5
            color: "black"
        }

        Text {
            id: activityText
            width: contentWidth
            height: indicator.height/5
            anchors { horizontalCenter: parent.horizontalCenter; top: indicator.bottom; topMargin: 20 }
            font.pixelSize: height*3/4
            font.bold: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: theme.textHighlightColor
            text: busyIndicator.state == "RUNNING" ? busyIndicator.activity : "Cancelling..."
        }

        Rectangle {
            id: closeButtonArea
            width: 20
            height: width
            radius: width/2
            x: textRec.x+textRec.width-width/2
            y: textRec.y-height/2
            color: mouseArea.pressed ? theme.highlightGradientStart : "black"
            opacity: busyIndicator.state == "RUNNING" ? 1 : 0
            Behavior on opacity {NumberAnimation {duration: 200}}
            visible: opacity != 0

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
                onClicked: {busyIndicator.state = "CANCELLING"; busyIndicator.cancel()}
            }
        }
    }
}
