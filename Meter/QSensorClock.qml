import QtQuick 2.0
import QmlCustomItem 1.0

Item
{
    id: root
    property int dataUpdate: 0
    property int updateInterval: 5

    property int textSize: 25
    property bool textBold: false
    property string textColor: "#000000"
    property bool textVisible: true

    property alias unfilledColor: chartID.unfilledColor
    property alias filledColor: chartID.fillColor
    property alias bottomColor: chartID.bottomColor
    property alias centerColor: chartID.centerColor

    property int thickness: 25

    width: 200
    height: 200

    QCircleMeter
    {
        id: chartID

        property int diffData: 0

        width: root.width
        height: root.height
        anchors.centerIn: parent

        thickness: root.thickness

        data: 0
        Behavior on data
        {
            // duration is scaled from 100ms to 300ms
            NumberAnimation
            {
                duration: chartID.diffData < 10 ? 150 :
                                                  chartID.diffData < 30 ? 200 :
                                                  chartID.diffData < 70 ? 250 :
                                                  300
                alwaysRunToEnd: true
                onStopped:
                {
                    chartID.diffData = 0
                }
            }
        }
    }

    Text
    {
        id: text
        visible: root.textVisible
        anchors.centerIn: chartID
        text: (chartID.data > 9 ? qsTr("%1%") : qsTr(" %1%")).arg(chartID.data)
        font.pixelSize: root.textSize
        font.bold: root.textBold
        color: root.textColor
    }

    Timer
    {
        id: updateDataTimer
        interval: root.updateInterval * 1000
        triggeredOnStart: false
        running: false
        repeat: true
        onTriggered:
        {
            if (root.dataUpdate !== chartID.data)
            {
                chartID.diffData = Math.abs(root.dataUpdate - chartID.data)
                chartID.data = root.dataUpdate
            }
        }
    }

    Component.onCompleted:
    {
        if (root.dataUpdate !== 0)
        {
            chartID.data = root.dataUpdate
        }
        updateDataTimer.start()
    }
}
