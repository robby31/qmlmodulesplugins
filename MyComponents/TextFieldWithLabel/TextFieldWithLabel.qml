import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id: label
    property alias label: labelTitle.text
    property alias fieldValue: textField.text
    property alias echoMode: textField.echoMode
    signal edited(string newValue)
    signal accepted()

    width: 100
    height: 22

    Row {
        id: row
        spacing: 10
        anchors.fill: parent
        Text {
            id: labelTitle
            width: contentWidth
            height: 14
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: height*3/4
            verticalAlignment: Text.AlignVCenter
        }
        TextField {
            id: textField
            height: 18
            width: parent.width-labelTitle.width-10
            anchors.verticalCenter: parent.verticalCenter
            onTextChanged: {edited(textField.text)}
            onAccepted: {label.accepted()}
        }
    }
}
