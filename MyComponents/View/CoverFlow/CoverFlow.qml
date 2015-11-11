import QtQuick 2.0

Rectangle {
    id: coverFlowView
    property alias model: list_item.model
    property var backModel
    property var textBackQuestion
    property string fadeColor : "#ffffff"
    property real reflectRatio : 0.5

    signal selectedFrontItem(string id)
    signal selectedBackItem(string id)

    function setCurrentItemName(name) {
        itemName.text = name
    }

    function gotoIndex(idx) {
        var pos = list_item.contentX;
        var destPos;
        list_item.positionViewAtIndex(idx, ListView.Center);
        destPos = list_item.contentX;
        anim.from = pos;
        anim.to = destPos;
        anim.running = true;
    }
    NumberAnimation { id: anim; target: list_item; property: "contentX"; duration: 300 }

    width: 800
    height: 600

    Image {
        id: floor
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "Image/floor.jpg"
    }

    Text {
        id: itemName
        anchors {horizontalCenter: parent.horizontalCenter; top: parent.top; topMargin: parent.height/8}
        font.pixelSize: 18
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        text: '<b>'+ "" + '</b>'
        color: "black"
    }

    ListView {
        id: list_item
        width: parent.width
        height: parent.height
        anchors.fill: parent
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        preferredHighlightBegin: parent.width/3
        preferredHighlightEnd: parent.width/3*2
        spacing: 0
        boundsBehavior: Flickable.DragOverBounds
        leftMargin: coverFlowView.width/3
        rightMargin: coverFlowView.width/3
        delegate: CoverFlowDelegate {
            textQuestion: coverFlowView.textBackQuestion
            backModel: coverFlowView.backModel
            width: coverFlowView.width/3
            height: coverFlowView.height
        }
    }
}

