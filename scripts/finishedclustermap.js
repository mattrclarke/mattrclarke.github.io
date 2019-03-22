"use strict";

angular.module("wolas").controller("StudentGlobalController", controller);
controller.$inject = ["$scope", "$http", "$timeout"];

function controller($scope, $http, $timeout) {

  $scope.lives = [];

  $scope.suburb = "";
  $scope.postcode = "";
  $scope.state = null;
  $scope.status = "";
  $scope.source = "";
  $scope.code = "";
  $scope.usi = "";
  $scope.regonumber = "";
  $scope.certnumber = "";
  $scope.course = "";
  $scope.industry = "";
  $scope.start = "";
  $scope.finish = "";

  $scope.begin = "0";
  $scope.end = "0";
  $scope.page = 1;

  $scope.search = search;
  $scope.paginate = paginate;
  $scope.calculate = calculate;

  $scope.mdbselect();

  function search() {

    $scope.processing = true;

    var start = "";
    var finish = "";

    // conditionally parse the format of the start and finish date only when
    // the user has selected a date.

    if ($scope.start !== "") start = moment($scope.start).startOf("day")._d;
    if ($scope.finish !== "") finish = moment($scope.finish).endOf("day")._d;

    var querystring = "";
    querystring += "?suburb=" + ($scope.suburb || "");
    querystring += "&postcode=" + ($scope.postcode || "");
    querystring += "&state=" + ($scope.state || "");
    querystring += "&status=" + ($scope.status || "");
    querystring += "&source=" + ($scope.source || "");
    querystring += "&code=" + ($scope.code || "");
    querystring += "&usi=" + ($scope.usi || "");
    querystring += "&regonumber=" + ($scope.regonumber || "");
    querystring += "&certnumber=" + ($scope.certnumber || "");
    querystring += "&course=" + ($scope.course || "");
    querystring += "&industry=" + ($scope.industry || "");
    querystring += "&start=" + start;
    querystring += "&finish=" + finish;

    $http.get("reporting/students" + querystring)
      .then(function(response) {

        $timeout(function() {

          $scope.lives = response.data;
          $scope.calculate();


          let map = new google.maps.Map(document.getElementById('map'), {
            center: {
              lat: -27.4445608,
              lng: 153.1071103
            },
            zoom: 6,
          });

          // remove any results without a business as they are not going to be
          // shown on the map.

          var results = _.reject($scope.lives, {
            businessId: null
          });
          var missingPlaceIds = _.filter(results, {
            placeId: null
          });
          var dataset = _.without(results, missingPlaceIds);
          var grouped = _.groupBy(dataset, "placeId");
          $scope.missingPlaceIds = missingPlaceIds.length;
          placeMarkers(grouped, map);
          clusterMarkers(map);


          $scope.processing = false;
          $scope.page = 1;
        }, 500);
      })
      .catch(function(response) {
        $scope.processing = false;
        toastr.error(response.data.message);
      });
  }

  function calculate() {

    $scope.begin = null;
    $scope.end = null;

    if ($scope.page === 1) $scope.begin = 1;
    if ($scope.page !== 1) $scope.begin = (($scope.page - 1) * 20);

    let total = $scope.lives.length;
    let current = ($scope.page * 20);

    if (total >= current) $scope.end = current;
    if (total <= current) $scope.end = total;
  }

  function paginate(value) {
    var begin, end, index;
    begin = ($scope.page - 1) * 20;
    end = begin + 20;
    index = $scope.lives.indexOf(value);
    return (begin <= index && index < end);
  }

  let infoWindow = new google.maps.InfoWindow();
  let cluster = [];

  function placeMarkers(locations, map) {
    let businessDetails;
    Object.keys(locations).forEach(function(key) {
      let group = locations[key]
      let studentDetails = '';

      // Loop each of the grouped locations

      group.forEach(function(element, i, arr) {

        let icon = '';
        if (group.length > 1) {
          icon = {
            url: '/app/assets/icons/mapplus.png',
            scaledSize: new google.maps.Size(28, 45)
          };
        }

        let address;

        let businessPhone = element.businessPhone || '';

        // set up info window display options

        let businessDetails =
          "<p class=\"mb-1\"><b>Business: </b>" + element.trading + "</p>" +
          "<p class=\"mb-1\"><b>Number: </b>" + (element.businessNumber || '') + "</p>" +
          "<p class=\"mb-1\"><b>Address: </b>" + (element.businessAddress || '') + "</p>" +
          "<hr class='mb-1 mt-1'>"

        studentDetails +=
          "<p class=\"mb-1\"><b>Name: </b>" + element.student + "</p>" +
          "<p class=\"mb-1\"><b>Assessor: </b>" + element.assessor + "</p>" +
          "<p class=\"mb-1\"><b>Qualification: </b>" + element.course + "</p>" +
          "<hr class='mb-1 mt-1'>"

        // append student details for groups with more than 1 student

        let content = (businessDetails += studentDetails)

        // Create marker for each location

        let marker = new google.maps.Marker({
          map: map,
          position: {
            lat: parseFloat(element.latitude),
            lng: parseFloat(element.longitude)
          },
          icon: icon,
        });
        cluster.push(marker)


        let markerDetails = "<div id='infoWindow'>" +
          "<div>" + content + "</div>" +
          "</div>";

        // Set contents of each marker pop up window, displayed on click

        google.maps.event.addListener(marker, 'click', (function(marker) {
          return function() {
            infoWindow.setContent(markerDetails);
            infoWindow.open(map, marker);
          }
        })(marker));

      });

    });
  }

  let clusterOptions = {
    // minimumClusterSize: 6,
    maxZoom: 10,
    gridSize: 30,
    styles: [{
        height: 55,
        url: "/app/assets/icons/cluster1.png",
        width: 28,
        anchor: [10, 30]
      },
      {
        height: 55,
        url: "/app/assets/icons/cluster2.png",
        width: 28,
        anchor: [10, 30]
      },
      {
        height: 55,
        url: "/app/assets/icons/cluster3.png",
        width: 28,
        anchor: [10, 30]
      },
      {
        height: 55,
        url: "/app/assets/icons/cluster4.png",
        width: 28,
        anchor: [10, 30]
      },
      {
        height: 55,
        url: "/app/assets/icons/cluster5.png",
        width: 28,
        anchor: [10, 140]
      }
    ]
  }

  function clusterMarkers(map) {
    var markerCluster = new MarkerClusterer(map, cluster, clusterOptions);
  }


}