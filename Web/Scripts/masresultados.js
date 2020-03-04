var MasResultados =
{
	Init: function (ul, mr, tbc)
	{
		this.baseObject = ul;
		this.maxPageRows = mr;
		this.toolBarContainer = tbc;
	},
	baseObject: null,
	maxPageRows: null,
	currentPage: 1,

	totalRows: 1,
	toolBarContainer: null,
	Redraw: function ()
	{
		this.totalRows = this.baseObject.find('> li').length - 1;
		this.totalPages = Math.ceil(this.totalRows / this.maxPageRows);

		var last = (this.maxPageRows * this.currentPage) - 1;

		this.baseObject.find('> li').each(function (index)
		{
			if (index > last) { return false; }
			$(this).show();
		});
		this.RedrawToolbar();
	},
	RedrawToolbar: function ()
	{
		
		if (this.totalRows <= 0 || this.totalRows == 1 || this.currentPage == this.totalPages) { this.toolBarContainer.hide(); return false; }
		this.toolBarContainer.show();
	},
	Mas: function ()
	{
		this.currentPage++;
		this.Redraw();
	}
};