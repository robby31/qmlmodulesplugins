import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.1
import MyComponents 1.0

Item {
    id: fileSelector
    property string label: question
    property variant fieldValue: value
    signal edited(string newValue)
    signal accepted()

    width: 100
    height: 32
    anchors.fill: parent

    Row {
        id: row
        spacing: 10
        anchors.fill: parent

        TextFieldWithLabel {
            id: label
            width: parent.width-button.width-20
            anchors.verticalCenter: parent.verticalCenter
            label: question
            fieldValue: value ? value : ""
            focus: true
            onEdited: delegate.ListView.view.model.setDataByStringRole(index, newValue, "value")
            onAccepted: {}
        }

        Button {
            id: button
            iconSource: "../../Image/open.png"
            height: 30
            width: 30
            anchors.verticalCenter: label.verticalCenter
            onClicked: {selectFileDialog.visible = true}
        }
    }

    FileDialog {
        id: selectFileDialog
        title: "Select File"
        selectExisting: true
        visible: false
        nameFilters: ["Csv Files (*.csv)"]
        onAccepted: {label.fieldValue = selectFileDialog.fileUrl}
    }
}
