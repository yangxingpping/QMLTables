import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import FluentUI

Rectangle{
    id: r
    //anchors.fill: parent
    //color: "blue"
    onHeightChanged: {
        if(tbModel.rowCount>0){
            var hasHeightForContent = height - sep.y - sep.height;
            var actualContentHeigth = hasHeightForContent >= (tbModel.rowCount + 1) * tb.rowSpacing + tbModel.rowCount * contentHeigth ? (tbModel.rowCount + 1) * tb.rowSpacing + tbModel.rowCount * contentHeigth : hasHeightForContent;
            updateContentHeigth(actualContentHeigth);
        }
    }

    property int ww:0
    property int hh:0
    property int erow: 0
    property int ecol: 0
    property string editData

    property int hhHeigth: 30;
    property int contentHeigth: 36;
    property color headerBorderColor: "blue";
    property color contentBorderColor: "red";
    property var enableCells: [];
    property var disableCells: [1, 5, 8];
    property var cellsWidthRatio: [0.5,2,1,1,1]
    property var titleModel: null;
    property var tbModel: null;
    property int maxshowRow: 3;

    function upateHeigth(allocHeight){
        var maxNeedHeigth = sep.y + sep.height + (tbModel.rowCount + 1) * tb.rowSpacing + tbModel.rowCount * contentHeigth;
        if(maxNeedHeigth <= allocHeight){
            height = maxNeedHeigth;
        }
        else{
            height = allocHeight;
        }
    }

    function updateContentHeigth(h){
        rectContent.height = h;
    }
    function isCellEditable(row, col){
        var indx = row * tbModel.columnCount + col;
        if(r.disableCells.length>0){
            var ret = r.disableCells.find((element) => element === indx);
            return ret === undefined;
        }
        else{
            var ret = r.enableCells.find((element) => element === indx);
            return ret !== undefined;
        }
    }

    Rectangle{
        id: rectHHearder
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        color: "transparent" // r.headerBorderColor;
        height: r.hhHeigth
        FluRectangle{
            radius: [8,8,0,0];
            anchors.fill: parent
            color: r.headerBorderColor;
            HorizontalHeaderView {
                id: horizontalHeader
                anchors.centerIn: parent
                width: parent.width - 2 * columnSpacing;
                height: parent.height - 2 * rowSpacing;
                syncView: tb
                interactive: false
                rowSpacing: 1
                columnSpacing: 1

                rowHeightProvider: function(row){
                    return r.hhHeigth;
                }
                clip: true
                model: titleModel
                delegate: FluRectangle {
                    implicitHeight: horizontalHeader.implicitHeight
                    implicitWidth: horizontalHeader.implicitWidth
                    radius: column === 0 ? [8,0,0,0] : (column===titleModel.count-1 ? [0,8,0,0] : [0,0,0,0])
                    //radius: 8
                    Label {
                        anchors.fill: parent
                        text: name
                        opacity: 1.0
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }


    Rectangle{
        id: sep
        height: 2
        width: parent.width
        anchors.top: rectHHearder.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "blue"
    }
    Component{
        id: cpEdit
        TextField{
            id: tfEdit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft //Text.AlignHCenter
            text: r.editData
            width: r.ww
            height: r.hh
            onTextChanged: {
                r.editData = text
            }
            Component.onCompleted: {
                forceActiveFocus()
            }

            onAccepted: {
                console.log("accepted");
                return true;
            }
        }
    }

    Component{
        id: cpComb
        ComboBox {
            editable: false
            width: r.ww
            height: r.hh
            model: ListModel {
                id: model
                ListElement { text: "Banana" }
                ListElement { text: "Apple" }
                ListElement { text: "Coconut" }
            }
            onCurrentIndexChanged:function() {
                r.editData = model.get(currentIndex).text
                tbModel.setData(tbModel.index(r.erow, r.ecol), "display", r.editData);
            }
            Component.onCompleted: {
            }
        }

    }
    Rectangle{
        id: rectContent
        anchors.top: sep.bottom;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom;
        color: "transparent"
        FluRectangle{
            anchors.fill: parent
            radius:[0,0,8,8]
            color: r.contentBorderColor;
            TableView {
                id: tb
                anchors.centerIn: parent
                width: parent.width - 2 * columnSpacing
                height: parent.height - 2 * rowSpacing
                interactive: false
                rowSpacing: 1
                columnSpacing: 1
                model: tbModel
                ScrollBar.vertical: FluScrollBar {
                    policy: ScrollBar.AsNeeded
                }
                clip: true
                delegate: Rectangle {
                    id: cell
                    implicitWidth: column !== titleModel.count -1 ?  (tb.width - (titleModel.count) * tb.columnSpacing) / titleModel.count : (tb.width - (titleModel.count) * tb.columnSpacing) / titleModel.count + 1;
                    implicitHeight: (tb.height - tbModel.rowCount ) / tbModel.rowCount;
                    color: "transparent"
                    FluRectangle{
                        anchors.fill: parent
                        radius: (column === 0 && row === tbModel.rowCount -1) ? [0,0,0,8] : ((column===titleModel.count -1 && row === tbModel.rowCount -1)  ? [0,0,8,0] : [0,0,0,0] )
                        Text {
                            text: display
                            anchors.centerIn: parent
                            font.pointSize: 10
                        }
                        Component.onCompleted: {
                        }
                    }
                    TableView.editDelegate: Loader {

                        Component.onCompleted:{
                            r.erow = row;
                            r.ecol = column;
                            r.ww = cell.width;
                            r.hh = cell.height;
                            r.editData = display
                            if(row===0){
                                sourceComponent = cpEdit;
                            }
                            else if(row===1){
                                sourceComponent = cpComb;
                            }
                        }

                        TableView.onCommit: {
                            console.log("commit");
                            display = r.editData
                        }
                    }
                }
                Component.onCompleted: {
                }
            }
        }
    }
}
