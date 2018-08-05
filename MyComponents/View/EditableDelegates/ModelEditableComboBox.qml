import QtQuick 2.9
import QtQuick.Controls 2.2

ComboBox {
    id: control
    anchors.verticalCenter: parent.verticalCenter

    property bool isCurrentItem: false
    property string modelText: ""
    property color color: "black"
    property bool readOnly: false
    property alias placeholderText: textField.placeholderText

    property bool isCompleted: false

    signal updateModelText(string text)

    currentIndex: -1

    enabled: readOnly ? false : isCurrentItem

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: textRole ? model[textRole] : modelData
            color: control.color
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: control.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        anchors { right: parent.right; rightMargin: 5; verticalCenter: parent.verticalCenter }
        width: 12
        height: 8
        contextType: "2d"
        visible: isCurrentItem && control.focus

        Connections {
            target: control
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = control.pressed ? "#17a81a" : "#21be2b";
            context.fill();
        }
    }

    contentItem: TextField {
        id: textField
        anchors { left: control.left; right: canvas.left; rightMargin: 5; verticalCenter: control.verticalCenter }

        text: control.editable ? control.editText : control.displayText
        font: control.font
        color: control.pressed ? "#17a81a" : control.color
        verticalAlignment: TextInput.AlignVCenter

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.popup.visible
        selectByMouse: true

        inputMethodHints: control.inputMethodHints
        validator: control.validator

        background: Item { }
    }

    background: Rectangle {
        color: control.focus ? "white" : "transparent"
        border.color: control.focus ? "#21be2b" : "transparent"
    }

    function updateComboIndex(text) {
        var newIndex = -1
        if (model.toString().startsWith("SqlListModel")) {
            newIndex = model.findRow(text, textRole)
        } else {
            for (var i=0;i<model.count;++i) {
                if (model.get(i)[textRole] === text) {
                    newIndex = i
                    break
                }
            }
        }

        if (newIndex != currentIndex) {
//            console.log(index, "update combo text", text, newIndex, currentIndex, currentText)
            currentIndex = newIndex
        }
    }

    Component.onCompleted: {
        isCompleted = true
        editText = modelText
        updateComboIndex(modelText)
    }

    onModelTextChanged: {
        if (isCompleted) {
//            console.log(index, "model text changed", modelText)
            editText = modelText
            updateComboIndex(modelText)
        }
    }

    onActivated: {
        // text selected in the combo list
//        console.log("text selected in combo list", editText, displayText, modelText)
        var newText = editText
        editText = modelText
        updateComboIndex(modelText) // update currentIndex to be aligned to modelText
        updateModelText(newText)

        //console.log("end text selected", editText, displayText, currentIndex, currentText)
        focus = false
    }

    onAccepted: {
        // text written by keyboard
//        console.log("text entry by keyboard", editText, displayText, modelText)
        var newText = editText
        editText = modelText
        updateComboIndex(modelText) // update currentIndex to be aligned to modelText
        updateModelText(newText)

        //console.log("end text entry", editText, displayText, currentIndex, currentText)
        focus = false
    }

    Connections {
        target: model

        onDataChanged: {
            if (currentIndex >= topLeft.row && currentIndex <= bottomRight.row) {
//                console.log(index, "index to update", currentIndex, topLeft, bottomRight, roles, textRole)
                updateComboIndex(modelText)
            }
        }

        onRowsRemoved: {
//            console.log(index, "row removed", parent, first, last)
            if (currentIndex >= first && currentIndex <= last)
                updateComboIndex(modelText)
        }
    }
}
