import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtGraphicalEffects 1.0

Button {
    id: button

    property string icon: ""
    property string title: ""
    property color textColor: "lightgrey"

    width: 100
    height: 62

    checkable: true
    checked: false
    text: ""

    style: ButtonStyle {
        background: Item {
            Rectangle {
                id: hover
                anchors.fill: parent
                color: theme.menuHoverColor
                opacity: 0.2
                visible: button.hovered
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
                width: button.pressed || button.checked ? parent.width*3/4 : parent.width*3/4*1/2
                height: button.pressed || button.checked ? parent.height*5/10 : parent.height*5/10
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: parent.height*1/10
                }
                fillMode: Image.PreserveAspectFit
                source: button.icon
            }
            Text {
                id: buttonText
                width: parent.width*3/4
                height: parent.height*2/5
                anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom }
                font.pointSize: parent.height*3/4*0.2
                font.bold: false
                text: button.title
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: (button.pressed || button.checked)? "white" : button.textColor
            }
        }
    }
}
