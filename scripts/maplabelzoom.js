"use strict";

angular.module("wolas").controller("MapController", controller);
controller.$inject = ["$scope", "$http", "$stateParams", "$timeout", "$uibModal", "$state"];

function controller($scope, $http, $stateParams, $timeout, $uibModal, $state) {

  // ---------------------Initialise Variables------------------
  var map;
  $scope.locations;
  $scope.missingLocations = 0;
  let points = []
  let markers = []
  // -------------------------------------------------------------

  // -------------Request Route---------------------------------
  $http.get("assessor/" + $scope.assessorId + "/studentlocations")
    .then(function(response) {
      $scope.locations = response.data;

      console.log(response.data)

      _.each($scope.locations, function(location) {
        if (location.placeId == null)
          $scope.missingLocations++
      });

      $scope.locations = _.reject($scope.locations, {
        placeId: null
      });

      // Initialize map
      var map = new google.maps.Map(document.getElementById('map'), {
        center: {
          lat: -27.4445608,
          lng: 153.1071103
        },
        zoom: 6,
      });

      google.maps.event.addListener(map, 'zoom_changed', function() {
        if (map.getZoom() >= 13) showLabels();
        if (map.getZoom() < 13) eraseLabels();
      });

      var groupedLocations = _.groupBy($scope.locations, function(el) {
        return el.placeId;
      });


      function eraseLabels() {
        for (let i = 0; i < markers.length; i++) {
          markers[i].setLabel('');
        }
      }

      function showLabels() {
        for (let i = 0; i < markers.length; i++) {
          markers[i].setLabel(markers[i].groupSize);
        }
      }

      placeMarkers(groupedLocations, map)

    })
    .catch(function(response) {
      toastr.error(response.data.message);
    });
  // -------------------------------------------------------------

  // ---------------------Decorate Map---------------------------

  let infoWindow = new google.maps.InfoWindow();

  function placeMarkers(locations, map, waypoint) {
    Object.keys(locations).forEach(function(key) {
      let group = locations[key]
      let studentDetails = ''
      group.forEach(function(element, i, arr) {
        let students = arr.map(function(student) {
          return student['studentName']
        });

        let size = arr.length.toString();
        // Create markers, can also take options such as icon/placeId etc
        let marker = new google.maps.Marker({
          map: map,
          position: {
            lat: parseFloat(element.latitude),
            lng: parseFloat(element.longitude)
          },
          label: '',
          groupSize: size
        });

        markers.push(marker)

        // Html for marker pop up
        let studentLink = $state.href("application.life", {
          lifeId: element.id
        });
        let businessLink = $state.href("application.business", {
          businessId: element.businessId
        });
        let businessPhone = element.businessPhone || '';
        let supervisorPhone = element.supervisorMobile || '';
        let studentPhone = element.studentMobile || '';
        studentDetails +=
          "<p class=\"mb-1\"><b>Student: </b> <a href=\"" + studentLink + "\" target=\"_blank\">" + element.studentName + "</a></p>" +
          "<p class=\"mb-1\"><b>Student Ph: </b>" + "<a href=\"tel:" + element.mobile + "\">" + studentPhone + "</a></p>" +
          "<p class=\"mb-1\"><b>Supervisor: </b>" + element.supervisorName + "</p>" +
          "<p class=\"mb-1\"><b>Supervisor Ph: </b>" + "<a href=\"tel:" + element.mobile + "\">" + supervisorPhone + "</a></p>" +
          "<hr class=\"mb-2 mt-2\">"

        let markerDetails = '<div id="infoWindow">' +
          "<div>" +
          "<p class=\"mb-1\"><b>Business: </b> <a href=\"" + businessLink + "\" target=\"_blank\">" + element.trading + "</a></p>" +
          "<p class=\"mb-1\"><b>Address: </b>" + element.address + "</p>" +
          "<p class=\"mb-1\"><b>Phone: </b>" + "<a href=\"tel:" + element.number + "\">" + businessPhone + "</a></p>" +
          "</div>" + "<hr class=\"mb-2 mt-2\">" +
          "<div>" + studentDetails + "</div>" +
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
  // -------------------------------------------------------------
}