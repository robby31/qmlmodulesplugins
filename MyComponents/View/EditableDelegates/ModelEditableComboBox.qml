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

    onModelTextChanged: {
        var index = -1
        if (model.toString().startsWith("SqlListModel")) {
            index = model.findRow(modelText, textRole)
        } else {
            for (var i=0;i<model.count;++i) {
                if (model.get(i)[textRole] === modelText) {
                    index = i
                    break
                }
            }
        }

        currentIndex = index
    }

    onActivated: focus = false

    onAccepted: focus = false
}
