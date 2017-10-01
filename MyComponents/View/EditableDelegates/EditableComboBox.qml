import QtQuick 2.9
import QtQuick.Controls 2.2

ComboBox {
    id: combo

    width: 200
    height: 30

    property color color: "black"
    property string placeholderText: ""

    signal textUpdated()

    onActivated: textUpdated()

    delegate: ItemDelegate {
        width: combo.width
        text: combo.textRole ? (Array.isArray(combo.model) ? modelData[combo.textRole] : model[combo.textRole]) : modelData
        font.pointSize: combo.font.pointSize
        font.weight: combo.currentIndex === index ? Font.DemiBold : Font.Normal
        highlighted: combo.highlightedIndex == index
        hoverEnabled: combo.hoverEnabled
    }

    indicator: Canvas {
        id: canvas
        x: combo.mirrored ? combo.padding : combo.width - width - combo.padding
        y: combo.topPadding + (combo.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"
        visible: combo.focus

        Connections {
            target: combo
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = "black"
            context.fill();
        }
    }

    contentItem: TextField {
        leftPadding: !combo.mirrored ? 12 : combo.editable && activeFocus ? 3 : 1
        rightPadding: combo.mirrored ? 12 : combo.editable && activeFocus ? 3 : 1
        topPadding: 6 - combo.padding
        bottomPadding: 6 - combo.padding

        placeholderText: combo.placeholderText
        text: combo.editable ? combo.editText : combo.displayText

        enabled: combo.editable
        autoScroll: combo.editable
        readOnly: combo.popup.visible
        selectByMouse: true
        inputMethodHints: combo.inputMethodHints
        validator: combo.validator

        font: combo.font
        color: combo.color
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        opacity: combo.enabled ? 1 : 0.3

        background: Item { }
    }

    background: Rectangle {
        color: combo.focus ? "white" : "transparent"
        border.color: combo.focus ? "#21be2b" : "transparent"
    }

    onFocusChanged: {
        if (!focus && editable)
            editText = currentText
    }
}
