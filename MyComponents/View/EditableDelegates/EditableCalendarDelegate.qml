import QtQuick 2.3
import QtQuick.Controls 1.2

Item {
    id: delegate
    width: 100
    height: 62

    property bool showEditor: false

    Text {
        width: parent.width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        elide: styleData.elideMode
        text: styleData.value ? styleData.value : ""
        color: styleData.textColor
        visible: !(styleData.selected && showEditor)
    }

    Loader { // Initialize text editor lazily to improve performance
        width: 300
        height: 250

        sourceComponent: (styleData.selected && showEditor) ? editor : null

        Component {
            id: editor

            Calendar {

                onDoubleClicked: {
                    model.date = selectedDate
                    showEditor = false
                }

                Component.onCompleted: {
                    selectedDate = styleData.value
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onDoubleClicked: showEditor = true
        visible: styleData.selected && !showEditor
    }
}

