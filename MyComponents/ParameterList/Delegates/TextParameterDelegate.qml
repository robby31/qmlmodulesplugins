import QtQuick 2.0
import MyComponents 1.0

TextFieldWithLabel {
    id: label
    height: 22
    anchors.fill: parent
    label: question
    fieldValue: value ? value : ""
    focus: true
    onEdited: delegate.ListView.view.model.setDataByStringRole(index, newValue, "value")
    onAccepted: {parameterDialog.ok()}
}
