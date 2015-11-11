import QtQuick 2.0
import MyComponents 1.0

Rectangle {
    id: dataViewList
    property alias textQuestion: titleText.text
    property alias model: list.model
    signal selectedBackItem(string id)
    signal back
    width: 100
    height: 100
    color: "white"

    Rectangle {
        id: titleArea
        width: parent.width
        height: 40
        gradient: Gradient {
            GradientStop {position: 0; color: theme.gradientStartColor}
            GradientStop {position: 1; color: theme.gradientEndColor}
        }

        Rectangle {
            id: backButton
            width: 60
            height: 30
            anchors {left: parent.left; verticalCenter: parent.verticalCenter; leftMargin: 10}
            color: backButtonMouseArea.pressed? theme.highlightSelectColor : theme.highlightColor
            radius: 10
            border.color: theme.separatorColor
            clip: true
            opacity: 1

            Text {
                anchors.centerIn: parent
                font.pixelSize:14
                text: "< Back"
            }
            MouseArea {
                id: backButtonMouseArea
                anchors.fill: parent
                onClicked: back()
            }
        }
        Text {
            id: itemText
            anchors {right: parent.right; top: parent.top; rightMargin: 20; topMargin: 10}
            font.pixelSize: 16
            text: '<b>' + name + '</b>'
            color: theme.textColor
        }

        Text {
            id: titleText
            anchors {left: backButton.right; top: parent.top; leftMargin: 20; topMargin: 10}
            font.pixelSize: 16
            color: theme.textColor
        }

        Rectangle {
            id: titleSeparator
            width: parent.width
            height: 1
            anchors {left: parent.left; bottom: parent.bottom}
            color: theme.separatorColor
        }
    }

    ListView {
        id: list
        width: parent.width
        height: parent.height-titleArea.height
        anchors {top: titleArea.bottom; left: parent.left}
        delegate: BackViewListDelegate{id: delegate}
        focus: true
        highlightFollowsCurrentItem: false
        clip: true

        ScrollIndicator {
            id: scrollIndicator
            width: 10
            height: parent.height
            anchors {top: parent.top; right: parent.right}
            handleSize: list.visibleArea.heightRatio * list.height
            handlePosition: list.visibleArea.yPosition * list.height
            opacity: list.moving? 1.0 : 0.0
        }
    }
}
