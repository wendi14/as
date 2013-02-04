$$ = function(s) { //Create a special function for getting raw elements
    r = $(s).get()
    if(r.length > 1) { return r; } else { return r[0]; }
}

function page_init() {
    MochiToggle.initiate();
    MochiTabs.initiate();
}
$(page_init);

MochiToggle = {};
MochiToggle.initiate = function() {
    $('.toggle').click(function() {
        $('#'+$(this).attr('rel')).toggleClass('hide');
        if(this.className.indexOf('self') > 0) { $(this).toggleClass('hide'); };
        $(this).toggleClass('active');
        return false;
    });
}

MochiTabs = {};
MochiTabs.initiate = function() {
    var self = MochiTabs;
    self.tabs = $(".tabs li");
    self.tabs.each(function() {
        $(this).click(function() { self.selectTab($(this)); return false; });
    });
    //self.findTabInQueryString() ? self.selectTab(self.findTabInQueryString()) : self.selectTab(self.tabs[0]); //check query for a tab to highlight, else highlight first
}

MochiTabs.selectTab = function($tab) {
    var self = MochiTabs;
    self.tabs.each(function() {  //clear out the tab classes and hide content
        var element = $(this);
        element.removeClass("active");
        $('#'+element.children('a').attr('rel')).addClass("hide");
    });
    $tab.addClass("active");
    $('#'+$tab.children('a').attr('rel')).removeClass("hide");
}
// can has?
MochiTabs.findTabInQueryString = function() {
    //var self = TabManager;
    //var q = document.location.href.split('?')[1];
    //if(!q) {
    //    return false;
   // } else {
     //   var parm = parseQueryString(document.location.href.split('?')[1]).tab;
     //   var r = null;
    //    forEach(self.tabs, function(tab){
    //       getNodeAttribute(tab.getElementsByTagName('a')[0], "rel") == parm ? r = tab :0;
    //    });
    //    return r;
    //}
}

function createShadows() {
    $('.shadow').wrapInner("<div class='wrap1'><div class='wrap2'><div class='wrap3'><div class='content'></div></div></div></div>");
}
