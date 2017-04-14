import QtQuick 2.0


Item {
    id: bridgeGraph

    property string title
    property int yPace: 10
    property int yPrecision: 1
    property real barWidthFactor: 1.0
    property int axisFontPixelSize: 16
    property color backgroundGradientStart: "#ffffff"
    property color backgroundGradientEnd: "#f5f5f5"
    property color positiveFlowGradientStart: "#ff0000"
    property color positiveFlowGradientEnd: "#aa0000"
    property color negativeFlowGradientStart: "#00ff00"
    property color negativeFlowGradientEnd: "#00aa00"
    property color flowGradientStart: "#008cde"
    property color flowGradientEnd: "#0066bd"
    property color thresholdColor: "blue"
    property color gridColor: "lightgrey"
    property color labelColor: "black"
    property color valueTextColor: "black"
    property var model: 0

    width: 1000
    height: 400

    function roundDouble(value) {
        if (Math.abs(value) > 50.0)
            return value.toFixed(0)
        else if (Math.abs(value) > 1.0)
            return value.toFixed(1)
        else
            return value.toFixed(3)
    }

    onModelChanged: {
        var bridgeSum = 0;
        var min = 0;
        var max = 0;

        if (bridgeGraph.model)
        {
            for (var i=0; i<bridgeGraph.model.count; ++i)
            {
                bridgeSum += bridgeGraph.model.get(i).value;

                max = (bridgeSum > max) ? bridgeSum : max;
                min = (bridgeSum < min) ? bridgeSum : min;
            }
        }
        else
        {
            max = 10;
        }

        chartArea.bridgeMax = max;
        chartArea.bridgeMin = min;
    }
    //----------------------//
    //       Chart Title    //
    //----------------------//
    Text {
        text: bridgeGraph.title
        height: parent.height/8
        anchors {horizontalCenter: parent.horizontalCenter; top: parent.top}
        color: "black"
        font.pixelSize: 18
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: chartArea

        property real bridgeMax: 100
        property real bridgeMin: 0
        property real ratio: chartArea.height/(chartArea.bridgeMax-chartArea.bridgeMin)

        width: parent.width*30/32
        height: parent.height*9/12
        anchors {fill: parent; margins: bridgeGraph.height/8; leftMargin: bridgeGraph.width/10; rightMargin: bridgeGraph.width/14; bottomMargin: bridgeGraph.height/6}
        gradient: Gradient {
            GradientStop {position: 0.0; color: backgroundGradientStart}
            GradientStop {position: 1.0; color: backgroundGradientEnd}
        }

        //------------------------------//
        //       Vertical Separators    //
        //------------------------------//
        Row {
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: bridgeGraph.model

                Item {
                    width: chartArea.width/bridgeGraph.model.count
                    height: parent.height
                    Rectangle {
                        id: vSeparator
                        width: 1
                        height: parent.height
                        anchors.right: parent.right
                        color: gridColor
                    }
                }
            }
        }
        //--------------------------------//
        //       Horizontal Separators    //
        //--------------------------------//
        Column {
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: yPace+1

                Item {
                    width: parent.width
                    height: chartArea.height/yPace-1/yPace
                    Rectangle {
                        id: hSeparator
                        width: parent.width
                        height: 1
                        color: gridColor
                    }
                }
            }
        }

        //--------------------//
        //       bridge       //
        //--------------------//
        Row {
            anchors.fill: chartArea

            Repeater {
                model: bridgeGraph.model

                Item {
                    id: flowItem
                    height: chartArea.height
                    width: chartArea.width/bridgeGraph.model.count

                    Rectangle {
                        id: flowRectangle
                        property real offset: 0
                        property real bridgeValue: 0
                        property color gradientStart: flowGradientStart
                        property color gradientEnd: flowGradientEnd

                        anchors.horizontalCenter:  parent.horizontalCenter
                        width: barWidthFactor*parent.width
                        height: Math.abs(bridgeValue)*chartArea.ratio
                        y: bridgeValue>0 ? (chartArea.bridgeMax - offset - bridgeValue)*chartArea.ratio : (chartArea.bridgeMax - offset)*chartArea.ratio
                        gradient: Gradient {
                            GradientStop {position: 0.0; color: flowRectangle.gradientStart}
                            GradientStop {position: 1.0; color: flowRectangle.gradientEnd}
                        }

                        // label containing value
                        Text {
                            id: textLabel
                            width: contentWidth
                            height: contentHeight
                            text: !base && flowRectangle.bridgeValue >= 0 ? "+"+roundDouble(flowRectangle.bridgeValue) : roundDouble(flowRectangle.bridgeValue)
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: base ? "white" : valueTextColor
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            Component.onCompleted: {
                                if (flowRectangle.height < height)
                                    anchors.bottom = parent.top
                                else
                                    anchors.verticalCenter = parent.verticalCenter
                            }
                        }

                        Component.onCompleted: {
                            offset = 0;

                            for (var i=0; i<index; ++i)
                                offset += bridgeGraph.model.get(i).value;

                            if (index>0 && base) {
                                bridgeValue = offset
                                offset = 0
                            } else {
                                bridgeValue = value
                            }

                            if (!base)
                            {
                                if (bridgeValue>0) {
                                    gradientStart = positiveFlowGradientStart
                                    gradientEnd = positiveFlowGradientEnd
                                } else {
                                    gradientStart = negativeFlowGradientStart
                                    gradientEnd = negativeFlowGradientEnd
                                }

                            }
                        }
                    }
                }
            }
        }

        //----------------------------//
        //       Zero threshold       //
        //----------------------------//
//        Rectangle {
//            height: 1
//            width: parent.width
//            color: thresholdColor
//            y: chartArea.bridgeMax*chartArea.ratio
//        }
    }

    //-----------------------//
    // Flow Labels on X Axis //
    //-----------------------//
    Row {
        anchors {left: chartArea.left; right: chartArea.right; top: chartArea.bottom}
        spacing: 0

        Repeater {
            model: bridgeGraph.model

            Item {
                width: chartArea.width/bridgeGraph.model.count
                height: 40
                Rectangle {
                    id: vLine
                    width: 1
                    height: chartArea.height/20
                    anchors {top: parent.top; horizontalCenter: parent.horizontalCenter}
                    color: labelColor
                }
                Text {
                    anchors {horizontalCenter: parent.horizontalCenter; top: vLine.bottom; topMargin: 5}
                    width: parent.width
                    height: parent.height
                    elide: Text.ElideRight
                    text: name
                    color: labelColor
                    font.pixelSize: axisFontPixelSize
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
    //----------------------//
    // Flow Value on Y Axis //
    //----------------------//
    Column {
        anchors {bottom: chartArea.bottom; top: chartArea.top; right: chartArea.left}
        spacing: 0

        Repeater {
            model: yPace+1

            Item {
                width: 100
                height: chartArea.height/yPace-1/yPace
                Rectangle {
                    id: hLine
                    width: chartArea.height/20
                    height: 1
                    anchors {right: parent.right}
                    color: labelColor
                }
                Text {
                    anchors {verticalCenter: parent.top; right: hLine.left; rightMargin: 5}
                    text: (chartArea.bridgeMax - index*(chartArea.bridgeMax-chartArea.bridgeMin)/yPace).toFixed(yPrecision)
                    font.pixelSize: axisFontPixelSize
                    color: labelColor
                    horizontalAlignment: Text.AlignRight
                    clip: true
                }
            }
        }
    }
    //----------------//
    //       Frame    //
    //----------------//
    Rectangle {
        id: frame
        anchors.fill: chartArea
        color: "transparent"
        border.color: labelColor
    }
}
