import QtQuick 2.0
import QtQuick.Controls 1.2
import "tiger.js" as Tiger

Item {
    id: container
    width: 320
    height: 480

    Column {
        spacing: 6
        anchors.fill: parent
        anchors.topMargin: 12

        Text {
            font.pointSize: 24
            font.bold: true
            text: "Tiger with SVG path"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#777"
        }

        Canvas {
            id: canvas
            width: 320
            height: 280
            antialiasing: true

            property string strokeStyle: "steelblue"
            property string fillStyle: "yellow"
            property bool fill: true
            property bool stroke: true
            property real alpha: alphaCtrl.value
            property real scale: scaleCtrl.value
            property real rotate: rotateCtrl.value
            property int frame: 0

            onFillChanged: requestPaint();
            onStrokeChanged: requestPaint();
            onAlphaChanged: requestPaint();
            onScaleChanged: requestPaint();
            onRotateChanged: requestPaint();

            onPaint: {
                var ctx = canvas.getContext('2d');
                var originX = canvas.width/2 + 30
                var originY = canvas.height/2 + 60

                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.globalAlpha = canvas.alpha;
                ctx.globalCompositeOperation = "source-over";

                ctx.translate(originX, originY)
                ctx.scale(canvas.scale, canvas.scale);
                ctx.rotate(canvas.rotate);
                ctx.translate(-originX, -originY)

                ctx.strokeStyle = Qt.rgba(.3, .3, .3,1);
                ctx.lineWidth = 1;

                //! [0]
                for (var i = 0; i < Tiger.tiger.length; i++) {
                    if (Tiger.tiger[i].width != undefined)
                        ctx.lineWidth = Tiger.tiger[i].width;

                    if (Tiger.tiger[i].path != undefined)
                        ctx.path = Tiger.tiger[i].path;

                    if (Tiger.tiger[i].fill != undefined) {
                        ctx.fillStyle = Tiger.tiger[i].fill;
                        ctx.fill();
                    }

                    if (Tiger.tiger[i].stroke != undefined) {
                        ctx.strokeStyle = Tiger.tiger[i].stroke;
                        ctx.stroke();
                    }
                }
                //! [0]
                ctx.restore();
            }
        }
    }
    Column {
        id: controls
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        Slider {id: scaleCtrl ; minimumValue: 0.1 ; maximumValue: 1 ; value: 0.3 ;}
        Slider {id: rotateCtrl ; minimumValue: 0 ; maximumValue: Math.PI*2 ; value: 0 ;}
        Slider {id: alphaCtrl ; minimumValue: 0 ; maximumValue: 1 ; value: 1 ;}
    }
}