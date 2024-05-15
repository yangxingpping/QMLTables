import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels

Window {
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    Rectangle{
        visible: true;
        anchors.centerIn: parent
        width: parent.width * 2 /3
        height: parent.height * 2 / 3
        Dat{
            id: dat;
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            cellsWidthRatio: [0.5, 1, 1, 1, 1]
            titleModel:  ListModel{
                ListElement{
                    name: "Axis"
                }
                ListElement{
                    name: "DAT1"
                }
                ListElement{
                    name: "DAT2"
                }
                ListElement{
                    name: "DAT3"
                }
                ListElement{
                    name: "DAT3 Axis"
                }
            }
            tbModel: TableModel {
                TableModelColumn { display: "v0" }
                TableModelColumn { display: "v1" }
                TableModelColumn { display: "v2" }
                TableModelColumn { display: "v3" }
                TableModelColumn { display: "v4" }
                rows: [
                    {v0: "X0", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y1", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z2", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X3", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y4", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z5", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X6", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y7", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z8", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X9", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y11", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z12", v1: "1", v2: "2", v3: "3", v4: "4", }
                ]
                onRowCountChanged: {
                    dat.updateContentHeigth(150);
                }
            }
        }
        Rectangle{
            id: rectOthers;
            anchors.top: dat.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            border.width: 5
            border.color: "green"
        }

        onHeightChanged: {
            console.log("heigth changed=%1".arg(height));
            dat.upateHeigth(height/2);
        }
    }

    Rectangle{
        anchors.centerIn: parent
        width: parent.width * 2 /3
        height: parent.height * 2 / 3
        visible: false
        FillContainerTable{
            id: dat2;
            anchors.fill: parent;
            cellsWidthRatio: [1, 1, 1, 1, 1]
            titleModel:  ListModel{
                ListElement{
                    name: "Axis"
                }
                ListElement{
                    name: "DAT1"
                }
                ListElement{
                    name: "DAT2"
                }
                ListElement{
                    name: "DAT3"
                }
                ListElement{
                    name: "DAT3 Axis"
                }
            }
            tbModel: TableModel {
                TableModelColumn { display: "v0" }
                TableModelColumn { display: "v1" }
                TableModelColumn { display: "v2" }
                TableModelColumn { display: "v3" }
                TableModelColumn { display: "v4" }
                rows: [
                    {v0: "X0", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y1", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z2", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X3", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y4", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z5", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X6", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y7", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z8", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "X9", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Y11", v1: "1", v2: "2", v3: "3", v4: "4", },
                    {v0: "Z12", v1: "1", v2: "2", v3: "3", v4: "4", }
                ]
                onRowCountChanged: {
                    dat.updateContentHeigth(150);
                }
            }
        }

        onHeightChanged: {
            console.log("heigth changed=%1".arg(height));
            dat.upateHeigth(height/2);
        }
    }
}
