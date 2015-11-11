import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id: integerParameterDelegate
    property string label: question
    property alias fieldValue: numberField.value
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
            text: integerParameterDelegate.label
            font.pixelSize: height
            verticalAlignment: Text.AlignVCenter
        }
        SpinBox {
            id: numberField
            height: 18
            anchors.verticalCenter: parent.verticalCenter

            minimumValue: 1
            maximumValue: 99999
            width: parent.width-labelTitle.width-10
            onValueChanged: delegate.ListView.view.model.setDataByStringRole(index, numberField.value, "value")
        }
    }
}
