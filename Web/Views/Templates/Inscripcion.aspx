<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Inscripcion
</asp:Content>

<asp:Content ID="Content2"  ContentPlaceHolderID="MainContent" runat="server">


<script type="text/javascript">


    
    function validaCuit(CUIT) {
        var aMult = '6789456789';
        //document.get
        var aMult = aMult.split('');
        var sCUIT = String(CUIT);
        var iResult = 0;
        var aCUIT = sCUIT.split('');

        if (aCUIT.length == 11) {
            // La suma de los productos        
            for (var i = 0; i <= 9; i++) {
                iResult += aCUIT[i] * aMult[i];
            }
            // El módulo de 11        
            iResult = (iResult % 11);
            // Se compara el resultado con el dígito verificador
            if (iResult == aCUIT[10]) {return 0 }

        }
        alert("el CUIT es incorrecto, recuerde que debe ingresar el número sin los guiones");
        document.getElementById("txt_cuit").style.background = "#FE2E2E";

        return 1;

    }
    function validacion() {
        /*if (document.getElementById("select_arancel").value == "Beca") {
            document.getElementById("codigoProm").className = "";
        }
        if (document.getElementById("select_arancel").value != "Beca") {
            document.getElementById("codigoProm").className = "NoRequerido";
        }*/

        if (document.getElementById("mail").value != document.getElementById("mailRep").value) {
            alert("Error.El email y la confirmación deben coincidir.");
            return false;
        }
        var error = 0;
        var mensaje = "Existen campos incorrectos o vacíos. ";
        /*
        var CUIT = document.getElementById("txt_cuit").value;

        if (CUIT != '1') {
            error = error+validaCuit(CUIT);
        }
        */
        var div;
        if (document.getElementById("div_empresa").style.display == "none") {
            div = "div_contacto";
        }
        if (document.getElementById("div_empresa").style.display == "") {
            div = "div_empresa";
        }

        if (document.getElementById("dia").value != "" || document.getElementById("mes").value != "" || document.getElementById("ano").value != "") {
            if (parseInt(document.getElementById("dia").value) > 31) {
                error++;
                document.getElementById("dia").style.backgroundColor = "#F2F5A9"
            }
            if (parseInt(document.getElementById("mes").value) > 12) {
                error++;
                document.getElementById("mes").style.backgroundColor = "#F2F5A9"
            }
            if (parseInt(document.getElementById("ano").value) < 1900 || parseInt(document.getElementById("ano").value) > 2020) {
                error++;
                document.getElementById("ano").style.backgroundColor = "#F2F5A9"
            }
        }

        var o = document.getElementById(div);
        var x = o.getElementsByTagName("input");
        var y= o.getElementsByTagName("select");
        var i;

        for (i = 0; i < x.length; i++)
        {
            if (x[i].className.lastIndexOf("NoRequerido") == -1) 
            {
                if (x[i] == null || x[i].value == "" || /^\s+$/.test(x[i])) 
                {
                    

                    document.getElementById(x[i].id).style.backgroundColor = "#F2F5A9";
                    error++;
                }
            }

        }

        for (i = 0; i < y.length; i++) {
            //alert("Contenido : " + y[i].innerHTML + " Clases: " + y[i].className + " Index: " + y[i].className.lastIndexOf("NoRequerido"));
            if (y[i].className.lastIndexOf("NoRequerido") == -1) {
                if (y[i] == null || y[i].value == "" || /^\s+$/.test(y[i])) {


                    document.getElementById(y[i].id).style.backgroundColor = "#F2F5A9";
                    error++;
                }
            }

        }

        if (document.getElementById("pregunta").value == null || document.getElementById("pregunta").value == "") {
            
            error++;   
        }


        var particular = 0;
        var empresa = 0;
        if (document.getElementById("porcentaje_part") != null) {
            if (document.getElementById("porcentaje_part").value != "") {
                particular = parseInt(document.getElementById("porcentaje_part").value);
            }
            if (document.getElementById("porcentaje_empresa").value != "") {
                empresa = parseInt(document.getElementById("porcentaje_empresa").value);
            }
            if (particular + empresa != 100) {
                alert("Error. La suma de los porcentajes debe ser 100%");
                return false;
            }
        }
        if (error != 0) {
            
            alert(mensaje);
            return false;
            
        }
        else {
            $("html, body").animate({ scrollTop: 0 }, "slow");
            document.getElementById("div_empresa").style.display = "";
            document.getElementById("div_contacto").style.display = "none";
            document.getElementById("btnInscribir").style.display = "";
            document.getElementById("btn_seguir").style.display = "none";
            document.getElementById("h3_pagina2").style.display = "";
            document.getElementById("h3_pagina1").style.display = "none";

            document.getElementById("hidden_txt_cuit").value = document.getElementById("txt_cuit").value;

            if (div == "div_contacto") {
                dataLayer.push({
                    'event': 'trackStep',
                    'step': 1
                });
            }
            else {
                dataLayer.push({
                    'event': 'trackStep',
                    'step': 2
                });
            }

            if (div =! "div_contacto") {
                return true;
            }
        }
    }

    function activarP() {
        if (document.getElementById("particular").checked == true) {
            document.getElementById("Cuil_fact").disabled = false;
            document.getElementById("Cuil_fact").className = "";
            document.getElementById("porcentaje_part").disabled = false;
            document.getElementById("porcentaje_part").className = "";

            
        }
        if (document.getElementById("particular").checked == false) {
            document.getElementById("Cuil_fact").disabled = true;
            document.getElementById("Cuil_fact").value = "";
            document.getElementById("Cuil_fact").className = "NoRequerido";
            document.getElementById("porcentaje_part").disabled = true;
            document.getElementById("porcentaje_part").className = "NoRequerido";
            document.getElementById("porcentaje_part").value = 0;
        }

    }

    function activarE() {
        if (document.getElementById("empresa").checked == true) {
            document.getElementById("Cuit_fact").disabled = false;
            document.getElementById("Cuit_fact").className = "";
            document.getElementById("porcentaje_empresa").disabled = false;
            document.getElementById("porcentaje_empresa").className = "";
            document.getElementById("razon_fact").disabled = false;
            document.getElementById("razon_fact").className = "";
            

        }
        if (document.getElementById("empresa").checked == false) {
            document.getElementById("Cuit_fact").disabled = true;
            document.getElementById("Cuit_fact").className = "NoRequerido";
            document.getElementById("Cuit_fact").value = "";
            document.getElementById("porcentaje_empresa").disabled = true;
            document.getElementById("porcentaje_empresa").className = "NoRequerido";
            document.getElementById("porcentaje_empresa").value = 0;
            document.getElementById("razon_fact").disabled = true;
            document.getElementById("razon_fact").className = "NoRequerido";
            document.getElementById("razon_fact").value = "";
        }

    }

   function validarKey(evt){
       var code = (evt.which) ? evt.which : evt.keyCode;        
       if(code==8){
       //backspace            
       return true;        
       }        
       else if(code>=48 && code<=57)        
       {            
       //is a number            
       return true;        
       }        
       else        
       {            
       return false;        
       }

}

function comprobarNumeros(id) {
    var numeros = "0123456789";
    var borrar = 0;
    var contenido = document.getElementById(id).value;
    for (i = 0; i < contenido.length; i++) {
        if (numeros.indexOf(contenido.charAt(i), 0) == -1) {
            borrar++;
        }
    }
    if (borrar != 0) {
        document.getElementById(id).value = "";
    }
}

function campoObligatorio(id) {
    if (document.getElementById(id).value == "") {
        document.getElementById(id).style.background = "#FE2E2E";
    }
    else {
        document.getElementById(id).style.background = "#FFFFFF";
    }
}

function DisplayLbl() {
    if (document.getElementById("select_arancel").value == "Beca") {
        document.getElementById("lbl_beca").style.display = "";
    }
    if (document.getElementById("select_arancel").value != "Beca") {
        document.getElementById("lbl_beca").style.display = "none";
    }
}

function desvincular() {
    document.getElementById("txt_razon").disabled = false;
    document.getElementById("txt_razon").value = "";
    document.getElementById("tipoOrg").disabled = false;
    document.getElementById("tipoOrg").style.backgroundColor = "";
    document.getElementById("tipoOrg").style.color = "black";
    document.getElementById("txt_cuit").disabled = false;
    document.getElementById("txt_cuit").value = "";
    document.getElementById("txt_telEmpresa").disabled = false;
    document.getElementById("txt_telEmpresa").value = "";
    document.getElementById("txt_mailEmpresa").disabled = false;
    document.getElementById("txt_mailEmpresa").value = "";
    //document.getElementById("select_Socio").disabled = false;
    //document.getElementById("pyme").disabled = false;
    document.getElementById("calleEmp_nom").disabled = false;
    document.getElementById("calleEmp_nom").value = ""
    document.getElementById("calleEmp_num").disabled = false;
    document.getElementById("calleEmp_num").value = ""
    document.getElementById("emp_piso").disabled = false;
    document.getElementById("emp_piso").value = ""
    document.getElementById("emp_dpto").disabled = false;
    document.getElementById("emp_dpto").value = ""
    document.getElementById("emp_ciudad").disabled = false;
    document.getElementById("emp_ciudad").value = ""
    document.getElementById("emp_pais").disabled = false;
    document.getElementById("emp_pais").value = ""
    
}
function completarCuit(){
    if (document.getElementById("txt_cuit").value.length == 2 || document.getElementById("txt_cuit").value.length == 11) {
        document.getElementById("txt_cuit").value = document.getElementById("txt_cuit").value + "-";
    }
        
}
    
    </script>
    <br />
    <br />
    <div class="consultas-form estiloDiv" id="divDatos">
                <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:15px; color:#F2F5A9; max-width:100px; margin-bottom:14px;" for="Cuit_fact"><b>ATENCIÓN: Para que no se produzcan errores en la inscripción, asegúrese de que el navegador que utilice para realizar la misma sea Google Chrome.</b></label>
				<form action="/Facturacion" method="post" onsubmit="return validacion()" style="margin-top:18px; border-top:2px solid #FFF; padding-top:9px; font-family:'Trebuchet MS, Arial, Helvetica, sans-serif'">
                <div id="div_contacto">
                <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">DATOS DEL CONTACTO</h3>
					<table id="tabla1" style="width:100%">
                        <tr>
                            <td style="width:33%">
                                <label class="estiloLabel" for="name">Nombre*: </label>
                            </td>
                            <td style="width:33%">
                                <label class="estiloLabel" for="Cuit_fact">Apellido*: </label>
                            </td>
                        </tr>
                        
                        <tr>
                            <td style="width:33%">
                                <input onchange="campoObligatorio(this.id)"  id="nombre" name="nombre" title="Nombre del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Nombre *" value="<%=ViewData["nombre"] %>"  />
                            </td>
					        <td style="width:33%">
                                <input onchange="campoObligatorio(this.id)"  id="apellido" name="apellido" title="Apellido del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Apellido *" value="<%=ViewData["apellido"] %>" />
                            </td> 
                        </tr>

                        <tr>
                              <%
                                if (ViewData["tipoEvento"].ToString() != "WebCast")
                              {%>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Localidad donde hará el curso*: </label></td>
                            <% } %>
                            <td style="width:33%">&nbsp;</td>
                          
                        </tr>

                        <tr>
                        <%if (ViewData["tipoEvento"].ToString() != "WebCast")
                          {%>

                            <td style="width:33%"><select id="delegacion" name="delegacion"  class="halfWidth placeholder desplegable" placeholder="Delegación *">
                                <option></option>
						        <%if (ViewData["delegacionCentral"] != "")
                                { %>
                                <option><%=ViewData["delegacionCentral"]%></option>
                                <%} %>
                                <%if (ViewData["delegacion1"] != "")
                                  { %>
                                <option><%=ViewData["delegacion1"]%></option>
                                <%} %>
                                <%if (ViewData["delegacion2"] != "")
                                  { %>
                                <option><%=ViewData["delegacion2"]%></option>
                                <%} %>
                                <%if (ViewData["delegacion3"] != "")
                                  { %>
                                <option><%=ViewData["delegacion3"]%></option>
                                <%} %>
                                <%if (ViewData["delegacion4"] != "")
                                  { %>
                                <option><%=ViewData["delegacion4"]%></option>
                                <%} %>
                                <%if (ViewData["delegacion5"] != "")
                                  { %>
                                <option><%=ViewData["delegacion5"]%></option>
                                <%}
                          } %>
					        </select></td>
					
					       <td style="width:33%">&nbsp;</td> 
                        </tr>

                        <tr>

                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">E-mail*: </label></td>
					
					       <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Repetir e-mail*: </label></td> 
                        </tr>

                        <tr>

                            <td style="width:33%"><input onchange="campoObligatorio(this.id)"  id="mail" name="mail" title="E-mail del contacto"class="halfWidth placeholder estiloInput" type="text" placeholder="Correo electrónico *" value="<%=ViewData["emailaddress1"] %>" /></td>
					
					       <td style="width:33%"><input onchange="campoObligatorio(this.id)"  id="mailRep" 
                                   onpaste="return false"
                                   name="mail0" title="Repetir e-mail del contacto"
                                   class="halfWidth placeholder estiloInput" type="text" 
                                   placeholder="Repetir correo electrónico *" value="<%=ViewData["emailaddress1"] %>" /></td> 
                        </tr>
                        <tr>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Teléfono: </label></td>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Celular*: </label></td>
                        </tr>
                        <tr>
                            <td style="width:33%"><input onchange="campoObligatorio(this.id)" id="telefono" title="Teléfono del contacto" name="telefono" class="NoRequerido" type="text" placeholder="Teléfono particular" value="<%=ViewData["telephone1"] %>"/></td>
                            <td style="width:33%"><input onchange="campoObligatorio(this.id)"  id="celular" name="celular" title="Celular del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Teléfono celular *" value="<%=ViewData["mobilephone"] %>"/></td>
                        </tr>
                     </table>
                     <br />
                     <br />
                     <table id="tabla2" style="width:100%">
                        <tr>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Tipo de documento*: </label></td>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Número de documento*: </label></td>
                        </tr>

                        <tr>
                            <td style="width:33%"><select name="documentoTipo"  class="halfWidth placeholder desplegable" placeholder="Documento *">
						            <option>DNI</option>
						            <option>LC</option>
						            <option>LE</option>
					            </select>
                            </td>
                            <td style="width:33%"><input onchange="campoObligatorio(this.id)" readonly="readonly" id="DNI" name="DNI" title="Documento del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Número Documento *" value="<%=ViewData["DNI"]%>" /></td>    
                        </tr>

                        <tr>
                          <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Fecha de nacimiento (dd/mm/aaaa): </label></td>  
                          <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Sexo*: </label></td>
                        </tr>
                        
                        <tr>
                            <td style="margin:auto">
                            <input class="NoRequerido" style="width:20%; margin:auto" type="text" id="dia" name="dia" placeholder="Día" value="<%=ViewData["dia"]%>" />
                            <input class="NoRequerido" style="width:20%; margin:auto" type="text"  id="mes" name="mes" placeholder="Mes" value="<%=ViewData["mes"]%>" />
                            <input class="NoRequerido" style="width:33%; margin:auto" type="text"  id="ano" name="ano" placeholder="Año"value="<%=ViewData["ano"]%>" /></td>
                            <td style="width:33%"><select id="sexo" name="sexo"  class="halfWidth placeholder desplegable" placeholder="Sexo *">
                                
                                <%if (ViewData["sexo"].ToString() == "Femenino")
                                  { %>
                                    <option>Masculino</option>
                                    <option selected="selected">Femenino</option>
                                <%} %>
                                <%if (ViewData["sexo"].ToString() == "Masculino")
                                  { %>
                                    <option selected="selected">Masculino</option>
                                    <option>Femenino</option>
                                  <%} %>
                                <%if (ViewData["sexo"].ToString() != "Masculino" && ViewData["sexo"].ToString() != "Femenino")
                                    { %>
                                    <option selected="selected"></option>
                                    <option>Masculino</option>
                                    <option>Femenino</option>
                                    <%} %>
                            </select></td>
                        </tr>
                     </table>
                        <br />
                        <br />
                     <table style="width:99%">
                        <tr>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Área*: </label></td>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Cargo*: </label></td>
                        </tr>

                        <tr>
                             <td><select id="area" name="area"  class="halfWidth placeholder desplegable" placeholder="Área *">
                                        <option></option>
                                        <%
                                            string[] areas = ViewData["area"].ToString().Split('§');
                                            foreach (string area in areas)
                                            {
                                                if (area == ViewData["areaSelected"].ToString())
                                                {%>
                                                    <option selected="selected"><%=area%></option><%} %>
                                                 <%else{ %> 
                                                    <option><%=area%></option><%} %>   
                                        <%  }%>
                                    </select>
                              </td>
                              <td>
                                  <select id="cargo" name="cargo"  class="halfWidth placeholder desplegable" placeholder="Cargo *">
                                        <option></option>
                                        <%
                                            string[] roles = ViewData["RolCargoFuncion"].ToString().Split('§');
                                            foreach (string rol in roles)
                                            { 
                                                if (rol == ViewData["RolCargoFuncionSelected"].ToString())
                                                {%>
                                                    <option selected="selected"><%=rol%></option><%} %>
                                                 <%else{ %> 
                                                    <option><%=rol%></option><%} %>   
                                        <%  }%>
                                    </select>
                              </td>
                        </tr>

                       <tr>
                            <td>
                                <label class="estiloLabel" for="Cuit_fact">Título profesional*: </label>
                            </td>
                       </tr>

                       <tr>
                            <td>
                                <select id="titulo_prof" name="titulo_prof"  class="halfWidth placeholder desplegable">
                                <option></option>
                                <%
                                    string[] titulosProfesionales = ViewData["tituloProfesional"].ToString().Split('§');
                                    foreach (string titulo in titulosProfesionales)
                                            {
                                                if (titulo == ViewData["tituloProfesionalSelected"].ToString())
                                                {%>
                                                    <option selected="selected"><%=titulo%></option><%} %>
                                                 <%else{ %> 
                                                    <option><%=titulo%></option><%} %>   
                                        <%  }%>
                                        </select>
                            </td>
                       </tr>
               </table>
               <br />
               <br />
               <table style="width:99%">
                    <tr>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Tipo de domicilio*: </label></td> 
                    </tr>
                    <tr>
                        <td style="width:33%"><select id="tipo_domicilio" name="tipo_domicilio"  class="halfWidth placeholder desplegable" placeholder="Tipo *">
                            <option></option>
                            <%
                                string[] tipos = ViewData["tipoDomicilio"].ToString().Split('§');
                                foreach (string tipo in tipos)
                                        {
                                            if (tipo == ViewData["tipoDomicilioSelected"].ToString())
                                            {%>
                                                <option selected="selected"><%=tipo%></option><%} %>
                                             <%else{ %> 
                                                <option><%=tipo%></option><%} %>   
                                    <%  }%>    
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Dirección*: </label></td>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Número*: </label></td>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Piso: </label></td>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Departamento: </label></td>
                    </tr>
                    <tr>
                       <td style="width:33%"><input onchange="campoObligatorio(this.id)"  id="calle_nom" name="calle_nom" title="Dirección del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Calle *" value="<%=ViewData["address1_name"] %>"/></td>
					   <td style="width:33%"><input onblur="comprobarNumeros(this.id)" onchange="campoObligatorio(this.id)"  id="calle_num" name="calle_num" title="Número de dirección del contacto" class="halfWidth placeholder estiloInput" type="text" placeholder="Número *" value="<%=ViewData["huddle_address1numero"] %>" onkeypress="return validarKey(event)"/></td>
					   <td style="width:33%"><input  id="piso" name="piso" title="Piso de dirección del contacto" class="NoRequerido" type="text" placeholder="Piso" value="<%=ViewData["huddle_address1piso"] %>"/></td>
                       <td style="width:33%"><input  id="depto" name="depto" title="Departamento de dirección del contacto" class="NoRequerido" type="text" placeholder="Departamento" value="<%=ViewData["huddle_address1departamento"] %>"/></td>         
                    </tr>
                    <tr>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Ciudad*: </label></td>
                    </tr>
                    <tr>
                        <td style="width:33%"><input onchange="campoObligatorio(this.id)"  id="ciudad" name="ciudad" title="Ciudad del contacto"  class="halfWidth placeholder estiloInput" type="text" placeholder="Ciudad *" value="<%=ViewData["address1_city"] %>"/></td>
                    </tr>    
                </table>
                        
                     <label class="estiloLabel" for="Cuil_fact">¿Por qué medio se enteró del curso?*</label>
                    <br />
                     <select id="pregunta" name="pregunta" title="Pregunta final"  class="halfWidth placeholder desplegable" placeholder=" *">
                            <option></option>
                            <%
                                string[] preguntas = ViewData["pregunta"].ToString().Split('§');
                                foreach (string pregunta in preguntas)
                                        {%>
                                            <option><%=pregunta%></option>  
                                    <%  }%>    
                        </select>
                     </div> 
                      
			<div id="div_empresa" style="display:none">
				<h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">DATOS DE LA EMPRESA</h3>
				   <br />
                   <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:14px; color:#F2F5A9; max-width:100px; margin-bottom:14px;" for="Cuit_fact">En nuestra base de datos usted aparece como integrante de la siguiente empresa. De no ser así, por favor, haga click en el botón "Desvincular empresa" para poder ingresar nuevos datos. </label>
                    <br />
                    <br />
                    <input style="margin:auto;width:99%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 31px;" 
                            type="button" id="btn_desv" value="Click aquí para desvincular empresa" 
                            onclick="desvincular()" class="system-color-btn" />
                    <br />
                    <table id="table_empresa" style="width:100%">
                        <tr>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Razón social*: </label></td>
                                <td class="style2"><label class="estiloLabel" for="Cuit_fact">Cuit (sólo números)*: </label></td>
                        </tr>
                        <tr>
                            <td style="width:33%"><input  id="txt_razon" name="txt_razon" title="Razón social de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="Razón social *" value="<%=ViewData["nameEmpresa"] %>"/></td>
					        <td class="style2"><input onpaste="return false" maxlength="13" onkeypress="completarCuit()" id="txt_cuit" name="txt_cuit" title="CUIT de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="nn-nnnnnnnn-n *" value="<%=ViewData["sic"] %>"/></td>
					       
                        </tr>

                        <tr>
                                <td ><label class="estiloLabel" for="Cuit_fact">Tipo de organización*: </label></td>
                                </tr>
                                <tr>
                                <td style="width:33%"><select id="tipoOrg" name="tipoOrg"  class="halfWidth placeholder desplegable">
                            <option></option>
                            <%
                                string[] tiposOrg = ViewData["tipoOrganizacion"].ToString().Split('§');
                                foreach (string tipoOrg in tiposOrg)
                                        {
                                            if (tipoOrg == ViewData["tipoOrganizacionSelected"].ToString())
                                            {%>
                                                <option selected="selected"><%=tipoOrg%></option><%} %>
                                             <%else{ %> 
                                                <option><%=tipoOrg%></option><%} %>   
                                    <%  }%>    
                            </select></td>
                        </tr>
                    </table>
                    <br />
                    <table style="width:99%">
                        <tr>
                             <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Teléfono de la empresa*: </label></td>
                             <td class="style2"><label class="estiloLabel" for="Cuit_fact">E-mail de la empresa*: </label></td>
                        </tr>
                        <tr>
                            <td style="width:33%"><input  id="txt_telEmpresa" name="txt_telEmpresa" title="Teléfono de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="Teléfono *" value="<%=ViewData["telefonoEmpresa"] %>"/></td>
					        <td class="style2"><input  id="txt_mailEmpresa" name="txt_mailEmpresa" title="E-mail de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="Correo Electrónico *" value="<%=ViewData["mailEmpresa"] %>"/></td>
					       
                        </tr>       
                    </table>
                    <br />
                    <table style="width:99%">
                        <tr>
                                <td class="style2"><label class="estiloLabel" for="Cuit_fact">Dirección*: </label></td>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Número*: </label></td>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Piso : </label></td>
                                <td class="style2"><label class="estiloLabel" for="Cuit_fact">Departamento: </label></td>
                        </tr>
                        <tr>
					        <td class="style2"><input  id="calleEmp_nom" name="calleEmp_nom" title="Dirección de la empresa" class="halfWidth placeholder estiloInput" type="text" title="Nombre del contacto" placeholder="Calle *" value="<%=ViewData["dirEmpresa"] %>"/></td>
					        <td style="width:33%"><input  id="calleEmp_num" onblur="comprobarNumeros(this.id)" name="calleEmp_num" title="Número de dirección de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="Número *" value="<%=ViewData["huddle_numero"] %>" onkeypress="return validarKey(event)" /></td>
					        <td style="width:33%"><input  id="emp_piso" name="emp_piso" title="Piso de dirección de la empresa" class="NoRequerido" type="text" placeholder="Piso" value="<%=ViewData["huddle_piso"] %>"/></td>
					        <td class="style2"><input  id="emp_dpto" name="emp_dpto" title="Departamento de dirección de la empresa" class="NoRequerido" type="text" placeholder="Departamento" value="<%=ViewData["huddle_departamento"] %>"/></td>
                        </tr>
                        <tr>
                                
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Ciudad*: </label></td>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">País : </label></td>
                        </tr>
                        <tr>
                            
					        <td style="width:33%"><input  id="emp_ciudad" name="emp_ciudad" title="Ciudad de la empresa" class="halfWidth placeholder estiloInput" type="text" placeholder="Ciudad *" value="<%=ViewData["ciudadEmpresa"] %>"/></td>
					         <td style="width:33%"><input  id="emp_pais" name="emp_pais" title="País de la empresa" class="NoRequerido" type="text" placeholder="Pais" value="<%=ViewData["new_pais"] %>"/></td>
                        </tr>
                        
                     </table>   
                    
                    
                <br />
                
                <br />
                <br />
				<h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">RESPONSABLE RECURSOS HUMANOS</h3>
                    <table style="width:100%">
                        <tr>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Nombre responsable: </label></td>
                                <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Apellido responsable: </label></td>
                                
                        </tr>
                        <tr>
				            <td style="width:33%"><input  id="resp_nombre" name="resp_nombre" title="Nombre del Responsable" class="NoRequerido" type="text" placeholder="Nombre"/></td>
					        <td style="width:33%"> <input  id="resp_apellido" name="resp_apellido" title="Apellido del Responsable" class="NoRequerido" type="text" placeholder="Apellido"/></td>
					        
					    </tr>
                        <tr>
                        <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">Teléfono responsable : </label></td>
                            <td style="width:33%"><label class="estiloLabel" for="Cuit_fact">E-mail del responsable: </label></td>
                        </tr>
                        <tr>
                        <td style="width:33%"><input  id="resp_tel" name="resp_tel" title="Teléfono del Responsable" class="NoRequerido" type="text" placeholder="Teléfono"/></td>
                            <td style="width:33%"><input  id="resp_mail" name="resp_mail" title="E-mail del Responsable" class="NoRequerido" type="text" placeholder="Correo Electrónico"/></td>
				        </tr>
                    </table>
                    </div>
                    <br/>
                    
                
                <br/>
                <br/>
                <input type="hidden" id="hidden_disabled" name="hidden_disabled" value="<%=ViewData["READONLY"]%>" />
                <input type="hidden" id="hidden_inscripto" name="hidden_inscripto" class="NoRequerido" value="<%=Session["yaInscripto"]%>" />
                <input type="hidden" id="hidden_txt_cuit" name="hidden_txt_cuit" value="" class="NoRequerido"/>
                <input style="cursor:pointer; margin:auto;width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 52px;" type="button" id="btn_seguir" value="Seguir a datos de la empresa" class="system-color-btn" onclick="validacion()" />
                <input style="cursor:pointer; margin:auto;width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 52px; display:none" type="submit" id="btnInscribir" value="Siguiente" class="system-color-btn"  />
				<br />
                <br />
                <%if (Session["cursoGratis"].ToString() != "si")
                  { %>
                <h3 id="h3_pagina1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 1/4</h3>
				<h3 id="h3_pagina2" style="text-align:center;margin:auto;font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;display:none">Página 2/4</h3>
                <%} %>
                <%else
                    { %>
                    <h3 id="h3_pagina1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 1/3</h3>
				    <h3 id="h3_pagina2" style="text-align:center;margin:auto;font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;display:none">Página 2/3</h3>
                <%} %>
                </form>
                
</div>
<div   class="consultas-form estiloDiv" id="divError" style="display:none">
    <label class="estiloLabel" for="Cuit_fact">Lo sentimos. El DNI ingresado ya se encuentra inscripto a este curso. </label>
</div>
<script type="text/javascript">
    if (document.getElementById("hidden_disabled").value == "true") {
        var valor = document.getElementById("txt_cuit").value;

        //los hace no requerido 
        document.getElementById("txt_razon").className = "NoRequerido";
        document.getElementById("txt_cuit").className = "NoRequerido";
        document.getElementById("txt_telEmpresa").className = "NoRequerido";
        document.getElementById("txt_mailEmpresa").className = "NoRequerido";
        document.getElementById("calleEmp_nom").className = "NoRequerido";
        document.getElementById("calleEmp_num").className = "NoRequerido";
        document.getElementById("emp_piso").className = "NoRequerido";
        document.getElementById("emp_dpto").className = "NoRequerido";
        document.getElementById("emp_ciudad").className = "NoRequerido";
        document.getElementById("emp_pais").className = "NoRequerido";
        document.getElementById("tipoOrg").className = "NoRequerido";
        //deshabilita
        document.getElementById("txt_razon").disabled = true;
        document.getElementById("txt_cuit").disabled = true;
        document.getElementById("txt_telEmpresa").disabled = true;
        document.getElementById("txt_mailEmpresa").disabled = true;  
        document.getElementById("calleEmp_nom").disabled = true;
        document.getElementById("calleEmp_num").disabled = true;
        document.getElementById("emp_piso").disabled = true;
        document.getElementById("emp_dpto").disabled = true;
        document.getElementById("emp_ciudad").disabled = true;
        document.getElementById("emp_pais").disabled = true;
        document.getElementById("tipoOrg").disabled = true;
        document.getElementById("tipoOrg").style.backgroundColor = "#EBEBEB"; //#54
        document.getElementById("tipoOrg").style.color = "#545454";
        document.getElementById("hidden_txt_cuit").value = valor;

        
    }
    if (document.getElementById("hidden_inscripto").value == "true") {
        document.getElementById("divDatos").style.display = "none";
        document.getElementById("divError").style.display = "";
    }
    

</script>

    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
    <style type="text/css">
        .style2
        {
            width: 33%;
        }
        
        .estiloLabel 
        {
            margin:auto; 
            font-family: 'Roboto Condensed';
            font-weight:400; 
            font-size:14px; 
            line-height:29px; 
            color:#FFF; 
            max-width:100px; 
            margin-bottom:14px;
        }
        
        .estiloInput .NoRequerido
        {
            margin:auto;
            border-style: none; 
            border-color: inherit; 
            border-width: medium; 
            width:99%; 
            margin-bottom:8px; 
            height:23px; 
            /*
            font-family:'Trebuchet MS, Arial, Helvetica, sans-serif'; 
            font-size:12px; 
            color:#8e8d8d; 
            line-height:27px; 
            text-indent:4px; 
            display:inline-block;
            */
        }
        
        .estiloDiv
        {
            margin:auto; 
            width:60%; 
            display:block; 
            padding:18px 14px; 
            position:relative; 
            margin-bottom:20px; 
            background-color:#4f91cd; 
            /*
            font-family:'Trebuchet MS, Arial, Helvetica, sans-serif'; 
            font-size:12px; 
            color:#8e8d8d; 
            line-height:27px; 
            text-indent:4px; 
            display:inline-block;
            */
        }
        
    </style>
</asp:Content>
