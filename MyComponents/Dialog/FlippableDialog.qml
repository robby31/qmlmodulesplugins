import QtQuick 2.0

Item {
    width: 100
    height: 62

    property bool isVisible: false
    property real dialogWidth: 800
    property real dialogHeight: 500
    property alias item : loader.sourceComponent

    enabled: isVisible

    Rectangle {
        id: opaqueArea
        anchors.fill: parent
        color: "black"
        opacity: 0.6
        visible: false

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onWheel: {}
        }
    }

    Flipable {
        id: flipArea
        width: 0
        height: 0
        anchors.centerIn: parent

        front: Rectangle {anchors.fill: parent; color: "white"; border.color: "black"}
        back: Loader {id: loader; anchors.fill: parent}

        transform: Rotation {
            id: rotation
            origin.x: flipArea.width/2
            origin.y: flipArea.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: [
            State {
                name: "VISIBLE"
                PropertyChanges { target: rotation; angle: 180 }
                PropertyChanges { target: flipArea; width: dialogWidth }
                PropertyChanges { target: flipArea; height: dialogHeight }
                PropertyChanges { target: opaqueArea; visible: true }
                when: isVisible
            }
        ]

        transitions: Transition {
            NumberAnimation {target: rotation; property: "angle"; duration: 250}
            NumberAnimation {target: flipArea; properties: "width, height"; duration: 250}
        }
    }
}
