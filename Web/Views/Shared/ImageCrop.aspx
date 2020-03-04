<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<head>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js"></script>
<script type="text/javascript" src="/Scripts/jquery.Jcrop.min.js"></script>
<link href="/Content/CSS/Back/jquery.Jcrop.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/Javascript">

			var jCropApi=null;
			$(function(){
				$('#cropbox').Jcrop({
					aspectRatio: <%=ViewData["width"] %>/<%=ViewData["height"] %>,
					onSelect: updateCoords
				}, function(){jCropApi = this;});

			});

			function updateCoords(c)
			{
                $('#x').val(c.x/<%=((double)ViewData["scaleFactor"]).ToString(System.Globalization.CultureInfo.InvariantCulture) %>);
				$('#y').val(c.y/<%=((double)ViewData["scaleFactor"]).ToString(System.Globalization.CultureInfo.InvariantCulture) %>);
				$('#w').val(c.w/<%=((double)ViewData["scaleFactor"]).ToString(System.Globalization.CultureInfo.InvariantCulture) %>);
				$('#h').val(c.h/<%=((double)ViewData["scaleFactor"]).ToString(System.Globalization.CultureInfo.InvariantCulture) %>);
			};
			function selectAll(){
				var imageWidth=<%=(int)Math.Round((double)ViewData["scaleFactor"]*(int)ViewData["imageWidth"] ,0)%>;
				var imageHeight=<%=(int)Math.Round((double)ViewData["scaleFactor"]*(int)ViewData["imageHeight"] ,0) %>;
				var maxWidth=<%=ViewData["width"] %>;
				var maxHeight=<%=ViewData["height"] %>;
				var sf = <%=((double)ViewData["scaleFactor"]).ToString(System.Globalization.CultureInfo.InvariantCulture) %>;
				var imageSf = imageWidth/imageHeight;
                var w = imageWidth;
				var h = imageHeight;
				if(sf!=imageSf){
                   
					if((maxWidth*imageHeight/imageWidth)>=maxWidth){
						w = maxWidth*imageWidth/imageHeight;
					}
					else{
						h = (maxHeight*imageHeight/imageWidth);
					}
				}
                
                /*var wi = Number($('img').attr('width').replace(',','.'));
                var hi = Number($('img').attr('height').replace(',','.'));
                jCropApi.setSelect([0,0,wi,hi]);
                updateCoords({x:0,y:0,w:wi,h:hi});*/
				jCropApi.setSelect([0,0,w,h]);
                updateCoords({x:0,y:0,w:w,h:h});
			}
		</script>
<body style="overflow:auto;padding:0px;margin:0px;">
<img src="/Uploads/<%=ViewData["token"] %>/<%=ViewData["image"] %>" id="cropbox" width="<%=Math.Floor((double)ViewData["scaleFactor"]*(int)ViewData["imageWidth"]) %>" height="<%=Math.Floor((double)ViewData["scaleFactor"]*(int)ViewData["imageHeight"]) %>"/>

	<input type="hidden" id="x" name="x" />
	<input type="hidden" id="y" name="y" />
	<input type="hidden" id="w" name="w" />
	<input type="hidden" id="h" name="h" />
	

    <input type="button" id="all" style="display:none" onclick="selectAll()"/>
    
</body>
</html>
