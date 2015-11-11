import QtQuick 2.0

Column {
    id: informationSection

    property alias title: title.text
    property alias content: loader.sourceComponent

    width: 100
    spacing: -1
    Rectangle {
        id: rec
        width: parent.width-20
        height: 22;
        color: theme.highlightColor
        border.color: theme.separatorColor
        Text {
            id: title
            verticalAlignment: Text.AlignVCenter
            anchors {left: parent.left; verticalCenter: parent.verticalCenter; right: parent.right; bottom: parent.bottom; leftMargin: 10}
            font.pixelSize: 14
            text: "Description"
            color: theme.textColor
        }
    }

    Rectangle {
        id: contentArea
        color: "#fcfcfc"
        border.color: theme.separatorColor
        width: rec.width
        height: loader.height + 2*loader.anchors.margins
        anchors.horizontalCenter: rec.horizontalCenter

        Loader {
            id: loader
            width: parent.width-2*anchors.margins
            anchors {horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; margins: 10}
        }
    }
}
