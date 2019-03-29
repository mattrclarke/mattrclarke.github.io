HTML------------------------------------------------------------
<div id="box">

    <div class="img-with-options">
      <div class="hovereffect">
        <img id="rotatable" class="img-responsive" src="image.jpg" alt="">
          <img ng-src="{{portfolio.original}}" class="img-fluid mb-2" ng-if="portfolio.nooriginal !== true" id="rotatable">
          <img ng-src="{{portfolio.thumbnail}}" class="img-flud mb-2 d-block mx-auto" ng-if="portfolio.nooriginal === true" id="rotatable">
        <div class="overlay">
          <p class="icon-links">
              <span class="fa fa-expand zoom" onclick='return zoomIn()'></span>
              <span class="fa fa-compress" onclick='return zoomOut()'></span>
              <span class="fa fa-undo" onclick='return rotateLeft()'></span>
              <span class="fa fa-undo flipped" onclick='return rotateRight()'></span>
          </p>
      </div>
    </div>
  </div>
</div>

JAVASCRIPT------------------------------------------------------------
<script>
  var scale = ($('#rotatable').data('scale')) || 1;
  function rotateLeft(){
    var angle = ($('#rotatable').data('angle')) || 0;
    scale = 1;
    angle -= 90;
    $('#rotatable').css({'transform': 'rotate(' + angle + 'deg)'});
    $('#rotatable').data('angle', angle);
    return false;
  }

  function rotateRight(){
    var angle = ($('#rotatable').data('angle')) || 0;
    scale = 1;
    angle += 90;
    $('#rotatable').css({'transform': 'rotate(' + angle + 'deg)'});
    $('#rotatable').data('angle', angle);
    return false;
  }

  function zoomIn(){
    scale += 0.5;
    $('#rotatable').css({'transform': 'scale(' + scale + ')'});
    $('#rotatable').data('scale', scale);
    return false;
  }

  function zoomOut(){
    if(scale > 1) {
      scale -= 0.5;
    }
    $('#rotatable').css({'transform': 'scale(' + scale + ')'});
    $('#rotatable').data('scale', scale);
    return false;
  }
</script>



CSS------------------------------------------------------------

#box {
  height: 400px;
  width: 400px;
}

 .img-with-options {
   width: 100%;
   display: grid;
   text-align: -webkit-center;
 }

 .hovereffect {
   width: 100%;
   height: 100%;
   float: left;
   overflow: hidden;
   position: relative;
   text-align: center;
   cursor: default;
 }

 .hovereffect .overlay {
  margin-left: 40%;
  border-radius: 10px;

  opacity: 0.5;
  position: absolute;
  overflow: hidden;
  top: auto;
  bottom: 0;
  padding: 0 3px 0 5px;
  height: 1.5em;
  background: #000;
  color: #000;
  -webkit-transition: -webkit-transform 0.35s;
  transition: transform 0.35s;
  -webkit-transform: translate3d(0,100%,0);
  transform: translate3d(0,100%,0);
 }

 .hovereffect img {
   display: block;
   position: relative;
  -webkit-transition: -webkit-transform 0.35s;
  transition: transform 0.35s;
 }

 /* .hovereffect:hover img {
   -webkit-transform: translate3d(0,-10%,0);
  transform: translate3d(0,-10%,0);
 } */


 .hovereffect p.icon-links span {
  text-align: center;
  color: #fff;
  font-size: 1em;
 }

 .hovereffect p.icon-links {
   user-select: none;
   background: black;
 }


 .hovereffect:hover p.icon-links span:hover,
 .hovereffect:hover p.icon-links span:focus {
  color: #252d31;
  background-color: black;
 }

 .hovereffect p.icon-links span {
  -webkit-transition: -webkit-transform 0.35s;
  transition: transform 0.35s;
  -webkit-transform: translate3d(0,100%,0);
  transform: translate3d(0,100%,0);
  visibility: visible;
 }

 .hovereffect p.icon-links span:before {
  display: inline-block;
  margin: 4px 3px;
  speak: none;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
 }


.hovereffect:hover .overlay {
  -webkit-transform: translate3d(0,0,0);
  transform: translate3d(0,0,0);
}

 .hovereffect:hover p.icon-links span {
  -webkit-transform: translate3d(0,0,0);
  transform: translate3d(0,0,0);
 }

 .hovereffect:hover p.icon-links span:first-child {
  -webkit-transition-delay: 0.2s;
  transition-delay: 0.15s;
 }

 .hovereffect:hover p.icon-links span:nth-child(2) {
  -webkit-transition-delay: 0.15s;
  transition-delay: 0.1s;
 }

 .hovereffect:hover p.icon-links span:nth-child(3) {
  -webkit-transition-delay: 0.1s;
  transition-delay: 0.05s;
 }

 .flipped {
   transform: scaleX(-1) !important;
   -moz-transform: scaleX(-1) !important;
   -webkit-transform: scaleX(-1) !important;
   -ms-transform: scaleX(-1) !important;
 }