function Pagination (a,b,c,v,f){
	this.baseObject=a;
	this.totalRows=null;
	this.maxPageRows=b;
	this.toolBarContainer=c;
	this.currentPage=1;
	this.totalPages=null;
	if(f==null)
		this.ApplyFilters = function () { return true; };
	else if (typeof f.inner != "undefined")
	{
		this.ApplyFilters = function (row)
		{
			return (f.box.val().length == 0 || row.find(":first-child>:first-child>:first-child>:first-child").children().eq(f.column).text().toLowerCase().indexOf(f.box.val().toLowerCase()) > -1);
		};
	}
	else if (typeof f.box != "undefined"){
		this.ApplyFilters = function(row){
			return (f.box.val().length==0 || row.children().eq(f.column).text().toLowerCase().indexOf(f.box.val().toLowerCase())>-1);
		};
	}
	
	this.globalVariable=v;
	this.Redraw=function(){
		this.totalRows=this.baseObject.find('>tr').length-1;
		this.totalPages=Math.ceil(this.totalRows/this.maxPageRows);
		
		var first=this.maxPageRows*(this.currentPage-1); var last=first+this.maxPageRows-1;var classIndex=1;
		this.baseObject.fadeOut('fast');
		var oFilter= this.ApplyFilters;
		this.baseObject.find('>tr').each(function(index){
			
			$(this).find(':checkbox').attr('checked',false);
			if(index<first || index >last){$(this).hide();return true;}
			if(!oFilter($(this))){$(this).hide();return true;}
			$(this).addClass((classIndex%2==0?"tr-even":"tr-odd"));$(this).show();classIndex++;
		});
		$('#registrosTotal').text(this.totalRows + (classIndex-1!=1?' registros':' registro')+' Mostrando: '+(this.maxPageRows>this.totalRows?this.totalRows:this.maxPageRows));
		this.baseObject.fadeIn('fast');		
		this.RedrawToolbar();
	};
	
	this.RedrawToolbar=function(){
		if(this.totalRows==0 || this.totalRows==1)return false;
		var htmlOutput='<ul class="ul-floatright paginado"><li><a onclick="'+v+'.SetPage(1);">&laquo; primero</a></li><li><a onclick="'+v+'.SetPage('+(this.currentPage-1)+');">&laquo; anterior</a></li>';
		if(this.currentPage+6>this.totalPages){
			var inicio=(this.totalPages<=6?1:this.totalPages-6);
			var fin=this.totalPages;
		}
		else{
			var inicio=this.currentPage;
			var fin = inicio+6;
		}
		
		for(var i=inicio-4;i<=fin;i++){
			if(i<=0)continue;
			if(i>this.totalPages)break;
			if(i==this.currentPage+6){
				htmlOutput+='<li><a>...</a></li>';
				htmlOutput+='<li><'+(this.currentPage==i?'span class="paginado-active"':'a')+' onclick="'+v+'.SetPage('+this.totalPages+');" >'+this.totalPages+'</'+(this.currentPage==i?'span':'a')+'></li>';
			}
			else
				htmlOutput+='<li><'+(this.currentPage==i?'span class="paginado-active"':'a')+' onclick="'+v+'.SetPage('+i+');">'+i+'</'+(this.currentPage==i?'span':'a')+'></li>';

		}
                htmlOutput+='<li><a onclick="'+v+'.SetPage('+(this.currentPage+1)+');">siguiente &raquo;</a></li><li><a onclick="'+v+'.SetPage('+this.totalPages+');">&uacute;ltimo &raquo;</a></li></ul>';
		this.toolBarContainer.html(htmlOutput);
	}
	this.SetPage = function(page){
		if(page<1 || page >this.totalPages)return false;
		this.currentPage=page;
		this.Redraw();
	}
	this.ChangeMaxPageRows = function(m){
		this.maxPageRows = m;
		this.totalPages=Math.ceil(this.totalRows/m);
		this.currentPage=1;
		this.Redraw();
	}
	this.GetSelected = function(){
		var retval = new Array();
		this.baseObject.find(':checkbox').each(function(){
			if($(this).attr('checked')) retval[retval.length] = $(this).attr('id').replace("check","");
		});
		return retval;
	}
}
