import QtQuick
import QtQuick.Controls
import QtQuick.Shapes 1.6
Rectangle {
     id: r
     visible: true
     property int indicatorWidth : 1
     property color indicatorColor : "red"
     TreeView {
         anchors.fill: parent
         // The model needs to be a QAbstractItemModel
         model: MyTreeModel {
             id: tree_model
             Component.onCompleted: {
                 tree_model.resetItems();
             }
         }
         interactive: true
         delegate: TreeViewDelegate {
             id: delegateid
             display: AbstractButton.TextBesideIcon
             implicitWidth: isTreeNode ?  r.width / (2+1) * 2 : r.width / 2

             indicator: Item {
                 // Create an area that is big enough for the user to
                 // click on, since the image is a bit small.
                 readonly property real __indicatorIndent: delegateid.leftMargin + (delegateid.depth * delegateid.indentation)
                 x: !delegateid.mirrored ? __indicatorIndent : cell.width - __indicatorIndent - width
                 y: (delegateid.height - height) / 2
                 implicitWidth: 30
                 implicitHeight: 40 // same as Button.qml
                 Rectangle{
                     anchors.fill: parent
                     color: "yellow"
                 }
             }




             indentation: 30

             contentItem: Label{
                 text: model.display
                 elide: Text.ElideRight
                 color: "red"
                 horizontalAlignment: parent.isTreeNode ? Label.AlignLeft : Label.AlignHCenter
                 font.pixelSize: 10
             }
             TapHandler {
                 onTapped: {
                     console.log("tap handle onTapped...")
                 }
             }
             background: Rectangle{
                 id: bk
                 color: delegateid.palette.base
                 opacity:  1.0
                 radius: delegateid.row === delegateid.treeView.currentRow && delegateid.treeView.columns === 1 ? 5 : 0

             }
         }
     }
 }
