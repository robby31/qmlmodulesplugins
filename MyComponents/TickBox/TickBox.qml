import QtQuick 2.0

Rectangle {
    id: tickBox
    signal triggered
    property bool ticked: false

    width: 30
    height: 30
    radius: 5
    gradient: Gradient {
        GradientStop {position: 0; color: "#fff"}
        GradientStop {position: 1; color: "#ccc"}
    }

    border.color: theme.separatorColor
    border.width: 1

    Image {
        id: tickImage
        width: parent.width*3/4
        height: width
        visible: tickBox.ticked
        source: "Image/tick.png"
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: tickBox.triggered()
    }
}
