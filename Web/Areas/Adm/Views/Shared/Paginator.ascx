<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% 
    int Page = (int)ViewData["Paginator_Page"];
    int Pages = (int)Math.Ceiling((double)((int)ViewData["Paginator_Total"]) / ((int)ViewData["Paginator_PerPage"]));%>
<div class="tools-bot">
<ul class="ul-floatright paginado"><li><a onclick="SetPage(1);">&laquo; primero</a></li>
<li><a onclick="SetPage(<%=Page %>-1);">&laquo; anterior</a></li>
<% 
        int Inicio=0,Fin=0;
        if(Page+6>Pages){
			Inicio=(Pages<=6?1:Pages-6);
			Fin=Pages;
		}
		else{
			Inicio=Page;
			Fin = Inicio+6;
		}
		for(int i=Inicio-4;i<=Fin;i++){
			if(i<=0)continue;
			if(i>Pages)break;
            if (i == Page + 6)
            {
				%><li><a>...</a></li><li><<%=(Page==i?"span class=\"paginado-active\"":"a")%> onclick="SetPage(<%=Pages %>);" ><%=Pages%></'.($page==$i?'span':'a').'></li><%
            }
            else
            { 
				%><li><<%=(Page==i?"span class=\"paginado-active\"":"a")%> onclick="SetPage(<%=i %>);"><%=i %></<%=(Page==i?"span":"a")%>></li><%
            }
		}
        %><li><a onclick="SetPage(<%=Page %>+1);">siguiente &raquo;</a></li><li><a onclick="SetPage(<%=Pages %>);">&uacute;ltimo &raquo;</a></li></ul>
</div>