import QtQuick 2.3

Item {
    width: 100
    height: 62

    property Component editor
    property bool showEditor: false

    function setData(newValue) {
        model[styleData.role] = newValue
        showEditor = false
    }

    Text {
        id: textComponent
        width: parent.width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        elide: styleData.elideMode
        text: styleData.value ? styleData.value : ""
        color: styleData.textColor
        visible: !(styleData.selected && showEditor)
    }

    Loader { // Initialize text editor lazily to improve performance
        anchors.fill: parent
        sourceComponent: (styleData.selected && showEditor) ? editor : null
    }

    MouseArea {
        anchors.fill: parent
        onDoubleClicked: showEditor = true
        visible: styleData.selected && !showEditor
    }
}

