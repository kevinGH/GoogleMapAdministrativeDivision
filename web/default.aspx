<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="web._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>draw administrative division in google map</title>

    <script src="Scripts/jquery-2.1.4.js"></script>

    <style type="text/css">
        html {
            height: 100%;
        }

        body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map_canvas {
            height: 100%;
        }
    </style>
</head>
<body>
    <div id="map" style="width: 100%; height: 100%"></div>

    <script type="text/javascript">
        var map;
        var apikey = 'AIzaSyAJXLOlx_Zy8Rrx8q7HJ5urO1gpVkbfJ_g'; //請填入 google api key
        var counties;
        
        function loadScript() {
            var script = document.createElement('script');
            script.type = 'text/javascript';
            script.src = 'https://maps.googleapis.com/maps/api/js?callback=initializeMap&key=' + apikey + '&sensor=FALSE';
            //'&signed_in=true&callback=initialize';

            document.body.appendChild(script);
        }

        function initializeMap() {
            var mapOptions = {
                center: new google.maps.LatLng('23.7083', '120.5524'),
                zoom: 8,
                panControl: false,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                mapTypeControl: true,
                mapTypeControlOptions: {
                    style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
                    position: google.maps.ControlPosition.TOP_RIGHT
                },
                zoomControl: true,
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE,
                    position: google.maps.ControlPosition.RIGHT_TOP
                },
                scaleControl: true,
                streetViewControl: true,
                streetViewControlOptions: {
                    position: google.maps.ControlPosition.RIGHT_TOP
                }
            };


            map = new google.maps.Map(document.getElementById("map"), mapOptions);

            google.maps.event.addListenerOnce(map, 'idle', function () {
                map.data.addListener('mouseover', function (event) {
                    map.data.revertStyle();
                    map.data.overrideStyle(event.feature, { strokeWeight: 5 });
                });

                map.data.addListener('mouseout', function (event) {
                    map.data.revertStyle();
                });

                loadGeoJSON();    
            });
        }

        function loadGeoJSON() {
            // 縣(市)行政區域界線
            map.data.loadGeoJson('/jsondata/counties.json');

            // 臺北市行政區域界線 
            //map.data.loadGeoJson('/jsondata/63.json');
            
            // 高雄市行政區域界線 
            //map.data.loadGeoJson('/jsondata/64.json');
        }


        window.onload = loadScript;
    </script>
</body>
</html>
