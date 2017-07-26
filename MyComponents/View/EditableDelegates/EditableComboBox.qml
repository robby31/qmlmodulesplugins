import QtQuick 2.5
import QtQuick.Controls 2.1

Item {
    id: item
    width: 200
    height: 30

    property alias comboModel: combo.model
    property alias textRole: combo.textRole
    property alias currentText: combo.currentText
    property color color: "black"
    property int fontSize: 12

    property string initValue: ""

    signal textUpdated()

    ComboBox {
        id: combo
        anchors.fill: parent

        onActivated: textUpdated()

        background: Rectangle {
            color: combo.focus ? "white" : "transparent"
            border.color: combo.focus ? "#21be2b" : "transparent"
            border.width: combo.focus ? 2 : 1
        }

        contentItem: Text {
            text: combo.displayText
            font.pointSize: item.fontSize
            color: item.color
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        delegate: ItemDelegate {
            width: combo.width
            height: combo.height

            contentItem: Text {
                id: textItem
                text: modelData
                color: item.color
                font.pointSize: item.fontSize
                font.bold: combo.highlightedIndex == index
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

            highlighted: combo.highlightedIndex == index
        }

        indicator: Canvas {
            id: canvas
            x: combo.width - width - combo.rightPadding
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
    }

    Component.onCompleted: {
        combo.currentIndex = combo.find(initValue)
    }
}
