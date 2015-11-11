import QtQuick 2.0

Item {
    id: d
    property alias backModel: back_list.model
    property alias textQuestion: back_list.textQuestion

    width: parent.width/3
    height: parent.height

    Flipable {
        id: flipable
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        property bool flipped: false

        front: Item {
            anchors.fill: parent
            Image {
                id: itemImage
                width: parent.width*7/12*(1+Math.exp(-1/100*Math.abs((list_item.visibleArea.xPosition*list_item.contentWidth-index*(list_item.visibleArea.widthRatio)*d.width))))
                anchors.centerIn: parent
                source: "file:///"+image
                fillMode: Image.PreserveAspectFit
                onWidthChanged: {if (width > parent.width*7/12*1.4) coverFlowView.setCurrentItemName(name)}
            }
            Image {
                id: reflectedImage
                width: itemImage.width
                height: itemImage.height
                anchors {horizontalCenter: itemImage.horizontalCenter; top: itemImage.bottom; topMargin: 1}
                source: itemImage.source

                transform: Rotation {
                    origin.x: reflectedImage.width/2
                    origin.y: reflectedImage.height/2
                    axis.x: 1;
                    axis.y: 0;
                    axis.z: 0
                    angle: 180
                }
                opacity: 0.5
            }
            Rectangle {
                anchors.fill: reflectedImage
                width:  itemImage.width
                height: itemImage.height * reflectRatio

                gradient: Gradient {

                    GradientStop {
                        position: 0.0
                        color: "#00" + fadeColor.substring(1)
                    }
                    GradientStop {
                        position: 1.0
                        color: "#FF" + fadeColor.substring(1)
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                visible: list_item.interactive
                onClicked: {gotoIndex(index); flipable.flipped = !flipable.flipped; coverFlowView.selectedFrontItem(id)}
                onWheel: {
                    if (wheel.angleDelta.y > 0) list_item.flick(1100,0)
                    else list_item.flick(-1100,0)
                }

            }
        }

        back: BackViewList{
            id: back_list
            anchors.fill: parent
            enabled: !list_item.interactive
            onSelectedBackItem: coverFlowView.selectedBackItem(id)
            onBack: flipable.flipped = !flipable.flipped
        }

        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0
            axis.y: 1
            axis.z: 0
            angle: 0
        }

        states: State {
            name: "BACK"
            PropertyChanges { target: rotation; angle: 180 }
            PropertyChanges { target: flipable; width: coverFlowView.width }
            PropertyChanges { target: flipable; height: coverFlowView.height }
            PropertyChanges { target: d; z: 1000 }
            PropertyChanges { target: list_item; interactive: false }
//            AnchorChanges   {
//                target: flipable
//                anchors.verticalCenter: list_item.verticalCenter
//                anchors.horizontalCenter: list_item.horizontalCenter
//            }
            when: flipable.flipped
        }

        transitions: Transition {
            SequentialAnimation {
                PropertyAction { target: d; property: "z"; value: 10000 }
                ParallelAnimation {
                    NumberAnimation { target: rotation; property: "angle"; duration: 300 }
                    NumberAnimation { target: flipable; easing.type: Easing.InOutQuad; properties: "width, height"; duration: 300;  }
                }
            }
        }
    }
}
