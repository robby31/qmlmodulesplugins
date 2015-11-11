import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id: enumParameterDelegate
    property string label: question
    property alias fieldValue: enumField.currentText
    signal edited(string newValue)
    signal accepted()

    anchors.fill: parent
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
            text: enumParameterDelegate.label
            font.pixelSize: height
            verticalAlignment: Text.AlignVCenter
        }
        ComboBox {
            id: enumField
            height: 22
            width: parent.width-labelTitle.width-row.spacing
            anchors {verticalCenter: labelTitle.verticalCenter}
            model: enumList
            textRole: "name"
            onCurrentIndexChanged: delegate.ListView.view.model.setDataByStringRole(index, enumField.currentText, "value")
        }

    }
}
