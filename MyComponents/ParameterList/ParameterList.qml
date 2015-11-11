import QtQuick 2.0

Item {
    id: parameterList
    property alias model: list.model
    property var dialogCheckedList

    width: 400
    height: 200

    ListView {
        id: list

        anchors.fill: parent
        delegate: ParameterDelegate{}
        focus: true
        highlightFollowsCurrentItem: false
        clip: true        
    }
}
