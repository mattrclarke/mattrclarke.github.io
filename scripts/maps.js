"use strict";

angular.module("wolas").controller("AssessorDashboardController", controller);
controller.$inject = ["$scope", "$http", "$stateParams", "$state", "$sce", "$filter", "assessor", "students"];

function controller($scope, $http, $stateParams, $state, $sce, $filter, assessor, students) {

  $scope.assessorId = $stateParams.assessorId;

  $scope.assessor = assessor;
  $scope.assessor.iframe = $sce.trustAsHtml($scope.assessor.iframe);

  $scope.students = _.sortBy(students, function(student) {
    return student.unmarked + student.unread;
  }).reverse();

  $scope.studentLocations = _.once(function() {
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

        // google.maps.event.addListener(map, 'zoom_changed', function() {
        //   if (map.getZoom() >= 13) showLabels();
        //   if (map.getZoom() < 13) eraseLabels();
        // });

        var groupedLocations = _.groupBy($scope.locations, function(el) {
          return el.placeId;
        });

        // function eraseLabels() {
        //   for (let i = 0; i < markers.length; i++) {
        //     markers[i].setLabel('');
        //   }
        // }
        //
        // function showLabels() {
        //   for (let i = 0; i < markers.length; i++) {
        //     markers[i].setLabel(markers[i].groupSize);
        //   }
        // }

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

          let label = '';
          if (arr.length > 1) {
            label = arr.length.toString()
          }

          let size = arr.length.toString();
          let marker = new google.maps.Marker({
            map: map,
            position: {
              lat: parseFloat(element.latitude),
              lng: parseFloat(element.longitude)
            },
            label: label,
          });

          markers.push(marker)

          // Html for marker pop up
          let studentLink = $state.href("application.studentdashboard", {
            lifeId: element.lifeId
          });
          let businessPhone = element.businessPhone || '';
          let supervisorPhone = element.supervisorMobile || '';
          let studentPhone = element.studentMobile || '';
          studentDetails +=
            "<p class=\"mb-1\"><b>Student: </b> <a href=\"" + studentLink + "\" target=\"_blank\">" + element.studentName + "</a></p>" +
            "<p class=\"mb-1\"><b>Student Ph: </b>" + "<a href=\"tel:" + studentPhone + "\">" + studentPhone + "</a></p>" +
            "<p class=\"mb-1\"><b>Supervisor: </b>" + element.supervisorName + "</p>" +
            "<p class=\"mb-1\"><b>Supervisor Ph: </b>" + "<a href=\"tel:" + supervisorPhone + "\">" + supervisorPhone + "</a></p>" +
            "<hr class=\"mb-2 mt-2\">"

          let markerDetails = '<div id="infoWindow">' +
            "<div>" +
            "<p class=\"mb-1\"><b>Business: </b>" + element.trading + "</a></p>" +
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
  })
  // -------------------------------------------------------------


  $scope.todays = _.once(function() {

    // ---------------------Initialise Variables------------------
    var map;
    $scope.appointments;
    $scope.missingLocations = 0;
    let points = []
    // -------------------------------------------------------------

    // -------------Request Route---------------------------------
    $http.get("assessor/" + $scope.assessorId + "/appointments")
      .then(function(response) {
        $scope.appointments = response.data;
        console.log($scope.appointments)
        _.each($scope.appointments, function(location) {
          if (location.placeId == null)
            $scope.missingLocations++
        });

        $scope.appointments = _.reject($scope.appointments, {
          placeId: null
        });

        //--------GET LOCATION FOR ROUTING----------------
        // function getLocation() {
        //   if (navigator.geolocation) {
        //     navigator.geolocation.getCurrentPosition(showPosition);
        //   } else {
        //     console.log('not locating')
        //   }
        // }
        //
        // function showPosition(position) {
        //   points.push({
        //     lat: position.coords.latitude,
        //     lng: position.coords.longitude
        //   })
        //   console.log(points)
        // }
        //
        // getLocation();
        // ------------------------------------------------
        // Initialize map
        var map = new google.maps.Map(document.getElementById('appointments'), {
          center: {
            lat: -27.4445608,
            lng: 153.1071103
          },
          zoom: 6,
        });

        var groupedLocations = _.groupBy($scope.appointments, function(el) {
          return el.placeId;
        });

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

          let marker = new google.maps.Marker({
            map: map,
            position: {
              lat: parseFloat(element.latitude),
              lng: parseFloat(element.longitude)
            },
          });

          let studentLink = $state.href("application.studentdashboard", {
            lifeId: element.lifeId
          });
          let businessPhone = element.businessPhone || '';
          let supervisorPhone = element.supervisorMobile || '';
          let studentPhone = element.studentMobile || '';
          let start = new moment(element.start).format("h:mm a");
          let finish = new moment(element.finish).format("h:mm a");
          studentDetails +=
            "<p class=\"mb-1\"><b>Student: </b> <a href=\"" + studentLink + "\" target=\"_blank\">" + element.studentName + "</a></p>" +
            "<p class=\"mb-1\"><b>Student Ph: </b>" + "<a href=\"tel:" + element.mobile + "\">" + studentPhone + "</a></p>" +
            "<p class=\"mb-1\"><b>Supervisor: </b>" + element.supervisorName + "</p>" +
            "<p class=\"mb-1\"><b>Supervisor Ph: </b>" + "<a href=\"tel:" + element.mobile + "\">" + supervisorPhone + "</a></p>" +
            "<p class=\"mb-1\"><b>Time: </b>" + start + " - " + finish + "</p>" +
            "<hr class=\"mb-2 mt-2\">"

          let markerDetails = '<div id="infoWindow">' +
            "<div>" +
            "<p class=\"mb-1\"><b>Business: </b>" + element.trading + "</p>" +
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
    //-------------------------------------------------------------
  })

  // create a preserved list of the students that we'll do our $filter function
  // searching with as a clean dataset.
  $scope.preserved = angular.copy($scope.students);

  $scope.query = "";
  $scope.page = 1;
  $scope.page2 = 1;

  $scope.search = search;
  $scope.paginate = paginate;
  $scope.paginate2 = paginate2;

  // $http.get("assessor/" + $stateParams.assessorId + "/overduedebriefs")
  //   .then(function(response) {

  //     $scope.appointments = response.data;
  //   })
  //   .catch(function(response) {
  //     toastr.error(response.data.message);
  //   });

  function search() {

    var dataset = $scope.preserved;
    var filtered = $filter("filter")(dataset, $scope.query);

    $scope.students = filtered;
    $scope.page = 1;
  }

  // pagination for the assessors students table.
  function paginate(value) {
    var begin, end, index;
    begin = ($scope.page - 1) * 10;
    end = begin + 10;
    index = $scope.students.indexOf(value);
    return (begin <= index && index < end);
  }

  // pagination for the overdue debriefs tab.
  function paginate2(value) {
    var begin, end, index;
    begin = ($scope.page2 - 1) * 10;
    end = begin + 10;
    index = $scope.appointments.indexOf(value);
    return (begin <= index && index < end);
  }

}

angular.module("wolas").service("assessorDashboardPL", service);
service.$inject = ["$http", "$q"];

function service($http, $q) {

  function assessor(assessorId) {

    $http.get("assessor/" + assessorId)
      .then(function(response) {
        deferred.resolve(response.data);
      })
      .catch(function(response) {
        toastr.error(response.data.message);
      });

    var deferred = $q.defer();
    return deferred.promise;
  }

  function students(assessorId) {

    $http.get("assessor/" + assessorId + "/students?showcounts=true")
      .then(function(response) {
        deferred.resolve(response.data);
      })
      .catch(function(response) {
        toastr.error(response.data.message);
      });

    var deferred = $q.defer();
    return deferred.promise;
  }

  var methods = {
    assessor: assessor,
    students: students
  };

  return methods;
}