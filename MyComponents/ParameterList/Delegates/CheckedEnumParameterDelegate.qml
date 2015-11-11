import QtQuick 2.0
import QtQuick.Controls 1.1
import MyComponents 1.0

Item {
    id: enumParameterDelegate
    property var label: question
    property var model: enumList
    property var fieldValue
    signal edited(string newValue)
    signal accepted()

    anchors.fill: parent
    width: 100
    height: 32

    Row {
        id: row
        spacing: 10
        anchors.fill: parent

        Button {
            id: enumField
            width: 30
            height: 30
            anchors.verticalCenter: labelTitle.verticalCenter
            iconSource: "../../Image/filter.png"
            onClicked: {
                parameterList.dialogCheckedList.label = enumParameterDelegate.label
                parameterList.dialogCheckedList.model = enumParameterDelegate.model
                parameterList.dialogCheckedList.isVisible = true
            }
        }

        Text {
            id: labelTitle
            width: contentWidth
            height: 14
            anchors.verticalCenter: parent.verticalCenter
            text: enumParameterDelegate.label
            font.pixelSize: height
            verticalAlignment: Text.AlignVCenter
        }
    }
}
