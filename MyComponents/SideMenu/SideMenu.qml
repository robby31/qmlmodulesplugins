import QtQuick 2.0

Item {
    id: menu

    signal actionClicked(string name);

    property alias actions: actions.model

    function show() {state = "VISIBLE"}
    function hide() {state = "HIDDEN"}

    width: 500
    height: 500

    state: "HIDDEN"

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        preventStealing: true
        onClicked: { menu.state = (menu.state=="VISIBLE") ? "HIDDEN" : "VISIBLE";}
        onWheel: {}
    }

    Item {
        id: menuArea

        anchors {top: parent.top; right: parent.right; rightMargin: -width}
        height: parent.height
        width: 200

        Rectangle {
            id: menuBackground
            anchors.fill: parent
            color: "black"
            opacity: 0.9
        }

        ListView {
            id: actions
            width: parent.width
            anchors.fill: parent
            delegate: ActionDelegate {}
            focus: true
            clip: true
        }
    }

    states: [
        State {
            name: "HIDDEN";
            PropertyChanges { target: menuArea; anchors.rightMargin: -menuArea.width }
            PropertyChanges { target: mouseArea; visible: false }
        },
        State {
            name: "VISIBLE";
            PropertyChanges { target: menuArea; anchors.rightMargin: 0 }
            PropertyChanges { target: mouseArea; visible: true }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "anchors.rightMargin"; easing.type: Easing.InOutQuad; duration: 125 }
    }
}
