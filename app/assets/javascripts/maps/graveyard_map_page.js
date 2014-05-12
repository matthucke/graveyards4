function GraveyardMap(stuff)
{
    if (!stuff)
        return;
    
    for (var k in stuff)
        this[k] = stuff[k];
    
    this.locations = { };
    
    var me = this;
    
    this.$map = $('#' + this.mapId);
    $(window).bind('resize', function() {me.handleResize()});
    this.handleResize();
    // $('#selector-wrapper').draggable();
}

GraveyardMap.prototype.handleResize = function() {
    try {
        var windowHeight = $(window).height(); 
        var mapTop = this.$map.position().top;
        var mapHeight = Math.floor(windowHeight - mapTop - 8);
        this.$map.css('height', mapHeight + "px");
    } catch (ex) {
        console.dir(ex);
    }
};

GraveyardMap.prototype.importLocations = function(list) {
    for (var i in list)
    {
        var g = new GraveyardLocation(list[i]);
        var id = g.id;
        this.locations[id] = g;
    }
};

GraveyardMap.prototype.finishSetup = function() {
    this.initMap();
    this.plotLocations();
    this.finishMap();
    this.bindLinks();
    
    this.getUserLocation();
};

GraveyardMap.prototype.bindLinks = function() {
    var me = this;
    $('.location-selector a').bind('click', function(evt) { 
        evt.preventDefault();
        var $link = $(this);
        var id = (""+$link.attr('id')).split('-')[1];
        me.panToLocation(id);
        return false;
    });
};

GraveyardMap.prototype.panToLocation = function(id) {
    var g = this.locations[id];
    if (g)
    {
        var m = g.marker;
        if (m)
        {
            this.googleMap.setCenter(m.position);
        }
    }
};

GraveyardMap.prototype.initMap = function() {
    var gm = this.googleMap = new google.maps.Map(this.$map[0], {
        zoom: 10,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    this.bounds =  new google.maps.LatLngBounds();
    
    //gm.addControl(new GScaleControl());
    //gm.addControl(new GLargeMapControl());
    //gm.addControl(new GMapTypeControl());
    console.log("init map done");
    return gm;
};

GraveyardMap.prototype.plotLocations = function() {
    var me=this;
    var locs = _.values(this.locations);
    _.each(locs, function (g) { 
        me.plotLocation(g); 
    });
};

GraveyardMap.prototype.plotLocation = function(loc) {
    try {
        var ll = loc.toLatLng();
        if (!ll)
            return false;

        // embiggen bounding box.
        this.bounds.extend(ll);
        
        var m = new google.maps.Marker({
            position: ll,
            visible: true,
            clickable: true,
            map: this.googleMap,
            title: loc.name
        });
        loc.marker = m;
        return ll;
    } catch (ex) {
        console.log(ex);
    }
};

GraveyardMap.prototype.finishMap = function() {
    if (this.bounds.isEmpty())
    {
        alert("No locations were found to map.")
        return;
    }
    
    console.log("finish map setup");
    
    var c = this.bounds.getCenter();
    this.googleMap.setCenter(c);
    
    window.GM=this.googleMap;
    console.log("done");
    return;
    
    
};

GraveyardMap.prototype.getUserLocation = function() {
    if (!navigator.geolocation)
        return false;
    
    var me = this;
    
    navigator.geolocation.getCurrentPosition(function(pos) { 
        return me.handleGetPosition(pos);
    });
};

GraveyardMap.prototype.handleGetPosition = function(pos) {
    if (!pos || !pos.coords)
        return false;
    
    var c = pos.coords;
    var ll = new google.maps.LatLng(c.latitude, c.longitude);
    if (this.bounds.contains(ll))
    {
        console.log("apn to " + ll);
        this.googleMap.setCenter(ll);
        if (this.googleMap.getZoom() < 15)
            this.googleMap.setZoom(15);
    }
    console.log("user position");
    console.dir(pos);
    /*
    Geoposition {timestamp: 1378158088356, coords: Coordinates}
        coords: Coordinates
        accuracy: 22000
        altitude: null
        altitudeAccuracy: null
        heading: null
        latitude: 41.878114
        longitude: -87.629798
        speed: null
        __proto__: Coordinates
        timestamp: 1378158088356
        __proto__: Geoposition
        constructor: function Geoposition() { [native code] }
        __proto__: Object
*/
};
