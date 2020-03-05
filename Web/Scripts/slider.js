var div;
function irSlide() {
    var asd = document.getElementById("slider").getElementsByTagName("img");
    for (i = 0; i < asd.length; i++)
        if (asd[i].style.display != "none")
            window.location = asd[i].getAttribute("data-key");
}
function Slider(el,small)
{
	this.sddwn = el;
	this.smallVersion = small;
	this.currentIndex = 0;
	this.images = new Array();
	var that = this;
	el.find("img").each(function (i,o)
	{
		that.images[that.images.length] = o;
	});
    this.maxItems = this.images.length;
    this.sddwn.find(".showcase-data p").html("");
    this.sddwn.find("h2").attr("onclick", "irSlide()");
    this.sddwn.find("h2").attr("style", "cursor:pointer");
    var img = $(this.images[this.currentIndex]);
    img.attr("style", "cursor:pointer");
    img.attr("onclick", "irSlide()");

	this.initEvents();
}
Slider.prototype = {
    initEvents: function () {

        div = document.getElementById("slider");
        var obj = this;


        var handler = function (event) {
            var url;
            event.preventDefault();
            if (!obj.smallVersion && $(this).hasClass("showcase-navigation-current")) return false;
            var currentImage = $(obj.images[obj.currentIndex]);
            currentImage.hide();
            if (!obj.smallVersion)
                $(obj.sddwn.find(".showcase-navigation").find("li > a")[obj.currentIndex]).toggleClass("showcase-navigation-current");
            else
                $(obj.sddwn.find("li > a")[obj.currentIndex]).toggleClass("content-showcase-current");
            obj.currentIndex = Number($(this).text()) - 1;
            var newImage = $(obj.images[obj.currentIndex]);
            //document.getElementById("links").setAttribute("href", newImage.attr("data-key"));
            newImage.fadeIn();

            if (obj.smallVersion) {
                url = newImage.attr("data-key");
                obj.sddwn.find("h2").html(newImage.attr("alt"));
                obj.sddwn.find("h2").attr("onclick", "irSlide()");
                obj.sddwn.find("h2").attr("style", "cursor:pointer");
                newImage.attr("style", "cursor:pointer");
                newImage.attr("onclick", "irSlide()");
            }
            else {

                obj.sddwn.find(".showcase-data h2").attr("onclick", "irSlide()");
                obj.sddwn.find(".showcase-data h2").attr("style", "cursor:pointer");
                obj.sddwn.find(".showcase-data h2").html(newImage.attr("alt"));
                obj.sddwn.find(".showcase-data p").html("");
                newImage.attr("style", "cursor:pointer");
                newImage.attr("onclick", "irSlide()");
            }
            if (!obj.smallVersion)
                $(this).toggleClass("showcase-navigation-current");
            else
                $(this).toggleClass("content-showcase-current");

            event.stopPropagation();


        };
        if (obj.smallVersion)
            obj.sddwn.find("ul > li > a").on('click', handler);
        else
            obj.sddwn.find(".showcase-navigation").find("li > a").on('click', handler);
        setInterval(function () {
            var nextIndex = obj.currentIndex + 1;
            if (obj.currentIndex == (obj.maxItems - 1))
                nextIndex = 0;

            if (obj.smallVersion) {
                try {
                    obj.sddwn.find("ul > li > a")[nextIndex].click();
                }
                catch (err) {
                }
            } else {

                obj.sddwn.find(".showcase-navigation").find("li > a")[nextIndex].click();

            }
        }, 5000);
    }
}