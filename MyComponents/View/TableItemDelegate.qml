import QtQuick 2.3
import QtQuick.Controls 1.2

Rectangle {
    id: itemDelegate
    color: (mousearea.containsMouse && styleData.column!==0) ? theme.hoverColor : (content.model ? content.model.itemColor(styleData.column) : "transparent")
    border.color: "black"
    border.width: 1
    property bool isEditable: false

    property Component editor: Component {

        TextField {
            clip: true

            text: Number(styleData.value).toLocaleString(Qt.locale(), 'f', 3)

            validator: DoubleValidator {
                decimals: 3
                notation: DoubleValidator.StandardNotation
            }

            onAccepted: setData(Number.fromLocaleString(Qt.locale(), text))
        }
    }

    property bool showEditor: false

    function setData(newValue) {
        model[styleData.role] = newValue
        showEditor = false
    }

    Text {
        id: textComponent
        width: parent.width
        height: parent.height
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        text: styleData.value ? styleData.value : ""
        font.pointSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: "black"
        opacity: 0.6
        visible: !(styleData.selected && showEditor)
    }

    Loader { // Initialize text editor lazily to improve performance
        anchors.fill: parent
        sourceComponent: (styleData.selected && showEditor) ? editor : null
    }

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        onDoubleClicked: {
            if (itemDelegate.isEditable && styleData.column>0 && content.model.isEditable(styleData.row))
                showEditor = true
        }
        visible: styleData.selected && !showEditor
    }
}
