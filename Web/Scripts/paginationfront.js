var Pagination = (function ()
{
	function Pagination(ul, mr, varname, tbc)
	{
		this.baseObject = ul;
		this.maxPageRows = mr;
		this.v = varname;
		this.toolBarContainer = tbc;
	}
	Pagination.prototype.baseObject = null;
	Pagination.prototype.maxPageRows = null;
	Pagination.prototype.currentPage = 1;

	Pagination.prototype.totalRows = 1;
	Pagination.prototype.v = "";
	Pagination.prototype.toolBarContainer = null;
	Pagination.prototype.Redraw = function ()
	{
		this.totalRows = this.baseObject.find('> li').length - 1;
		this.totalPages = Math.ceil(this.totalRows / this.maxPageRows);

		var first = this.maxPageRows * (this.currentPage - 1); var last = first + this.maxPageRows - 1; var classIndex = 1;
		
		this.baseObject.fadeOut('fast');
		this.baseObject.find('> li').each(function (index)
		{
			if (index < first || index > last) { $(this).hide(); return true; }
			$(this).show();
		});
		this.baseObject.fadeIn('fast');
		this.RedrawToolbar();
	}
	Pagination.prototype.RedrawToolbar = function ()
	{
		if (this.totalRows == 0 || this.totalRows == 1) { this.toolBarContainer.html(''); return false; }
		var htmlOutput = '<li><a href="#" onclick="' + this.v + '.SetPage(' + (this.currentPage - 1) + ');" class="paginado-anterior">ANTERIOR</a></li>';
		if (this.currentPage + 6 > this.totalPages)
		{
			var inicio = (this.totalPages <= 6 ? 1 : this.totalPages - 6);
			var fin = this.totalPages;
		}
		else
		{
			var inicio = this.currentPage;
			var fin = inicio + 6;
		}

		for (var i = inicio - 4; i <= fin; i++)
		{
			if (i <= 0) continue;
			if (i > this.totalPages) break;
			if (i == this.currentPage + 6)
			{
				htmlOutput += '<li><a>...</a></li>';
				htmlOutput += '<li><a href="#" class="' + (this.currentPage == i ? 'paginado-numero active' : 'paginado-numero') + '" onclick="' + this.v + '.SetPage(' + this.totalPages + ');" >' + this.totalPages + '</a></li>';
			}
			else
				htmlOutput += '<li><a href="#" class="' + (this.currentPage == i ? 'paginado-numero active' : 'paginado-numero') + '" onclick="' + this.v + '.SetPage(' + i + ');">' + i + '</a></li>';

		}
		htmlOutput += '<li><a href="#"  class="paginado-siguiente" onclick="' + this.v + '.SetPage(' + (this.currentPage + 1) + ');">SIGUIENTE</a></li></ul>';
		this.toolBarContainer.html(htmlOutput);
	}
	Pagination.prototype.SetPage = function (page)
	{
		if (page < 1 || page > this.totalPages) return false;
		this.currentPage = page;
		this.Redraw();
	}
	return Pagination;
})();