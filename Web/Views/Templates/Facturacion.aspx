<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Facturacion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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


        if (document.getElementById("select_arancel").value == "Beca") 
        {
            document.getElementById("codigoProm").className = "";
            document.getElementById("divPorcentajes").style.display = "none";
        }
        else 
        {
            document.getElementById("codigoProm").className = "NoRequerido";
            document.getElementById("divPorcentajes").style.display = "";
        }

        var error = 0;
        var mensaje = "Existen campos incorrectos o vacíos. Recuerde seleccionar un modo de pago ";

        if (document.getElementById("pagoCamara").checked == false && document.getElementById("pagoOnline").checked == false) {
            error++;
            
            document.getElementById("pagoCamara").style.backgroundColor = "#F2F5A9";
            document.getElementById("pagoOnline").style.backgroundColor = "#F2F5A9";
        }


        var o = document.getElementById("divDatos");
        var x = o.getElementsByTagName("input");
        var y= o.getElementsByTagName("select");
        var i;

        for (i = 0; i < x.length; i++)
        {
            if (x[i].className != "NoRequerido") 
            {
                if (x[i] == null || x[i].value == "" || /^\s+$/.test(x[i])) 
                {
                    

                    document.getElementById(x[i].id).style.backgroundColor = "#F2F5A9";
                    error++;
                }
            }

        }

        for (i = 0; i < y.length; i++) {
            if (y[i].className != "NoRequerido") {
                if (y[i] == null || y[i].value == "" || /^\s+$/.test(y[i])) {


                    document.getElementById(y[i].id).style.backgroundColor = "#F2F5A9";
                    error++;
                }
            }

        }



        var particular = 0;
        var empresa = 0;
        if (document.getElementById("porcentaje_part") != null && document.getElementById("select_arancel").value != "Beca") {
            if (document.getElementById("porcentaje_part").value != "") {
                particular = parseInt(document.getElementById("porcentaje_part").value);
            }
            if (document.getElementById("porcentaje_empresa").value != "") {
                empresa = parseInt(document.getElementById("porcentaje_empresa").value);
            }
            if (document.getElementById("select_arancel").value != "NoSocio") {
                if (particular + empresa != 100) {
                    alert("Error. La suma de los porcentajes debe ser 100%");
                    return false;
                }
            }
        }

        //validacion para codigo
        if (document.getElementById("codigoProm").value != ""){
            var codigo = document.getElementById("codigoProm").value.toString();
            var codigoCorto = codigo.substring(0, codigo.length - 6);
            if (document.getElementById("CodigoEvento").value.toString() != codigoCorto.toString()) {
                alert("Error. El código de promoción es incorrecto.")
                error++;
            }
        }
        if (error != 0) {
            
            alert(mensaje);
            return false;
            
        }
        else {
            dataLayer.push({
                'event': 'trackStep',
                'step': 3
            });
                
            return true;
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

function campoObligatorio(id) {
    if (document.getElementById(id).value == "") {
        document.getElementById(id).style.background = "#FE2E2E";
    }
    else {
        document.getElementById(id).style.background = "#FFFFFF";
    }
}

function DisplayLbl(valor) {
    document.getElementById("pagoOnline").checked = false;
    document.getElementById("pagoCamara").checked = false;
    document.getElementById("trPagoCamara").style.display = "block";
    document.getElementById("pagoOnline").style.pointerEvents = "";

    
    if (valor == "Beca") 
    {
        //document.getElementById("lbl_beca").style.display = "";
        //alert(document.getElementById("divPorcentajes"));
        document.getElementById("divPorcentajes").style.display = "none";
        document.getElementById("valorMonto").innerHTML = " A calcular según bonificación.";
    }
    else 
    {
        var monto = document.getElementById(valor).value;
        document.getElementById("valorMonto").innerHTML = monto;
        //document.getElementById("lbl_beca").style.display = "none";
        document.getElementById("divPorcentajes").style.display = "";
    }

    if(valor == "Socio")
    {
        var monto = document.getElementById("monto").value;
        var socio =  document.getElementById("SocioInt").value;
        socio=monto+socio;
        document.getElementById("monto").value = socio;
    }
    if (valor == "NoSocio") {
        //document.getElementById("divPorcentajes").style.display = "none";
        //document.getElementById("valorMonto").innerHTML = 0;
        document.getElementById("pagoOnline").checked = true;
        document.getElementById("trPagoCamara").style.display = "none";
        document.getElementById("pagoOnline").style.pointerEvents = "none";
    }
    //if(document.getElementById("select_arancel").value == "No socio")
    //if(document.getElementById("select_arancel").value == "Colegio profesional")
    //if(document.getElementById("select_arancel").value == "Estudiante")
}

function PagoO() {
    if (document.getElementById("pagoOnline").checked == true) {
        document.getElementById("pagoCamara").checked = false;
    }
}

function PagoC() {
    if (document.getElementById("pagoCamara").checked == true) {
        document.getElementById("pagoOnline").checked = false;
    }
}
    
</script>
    <div>
        <br />
        <br />
        <div id="divDatos"  class="consultas-form" style="margin:auto; width:60%; display:block; padding:18px 14px; position:relative; margin-bottom:20px; background-color:#4f91cd; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block"> 
            <form action="/Respuesta" method="post" onsubmit="return validacion()" style="margin-top:18px; border-top:2px solid #FFF; padding-top:9px; font-family:'Trebuchet MS, Arial, Helvetica, sans-serif'">
                      
				    <div id="datos"></div>
                    
                
                <h3 id="monto" style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">DATOS DE FACTURACIÓN</h3>
                    <div style="width:100%;">
                        <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:15px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact"><i>De acuerdo con lo que usted elija se calculará el arancel a abonar. Para las opciones "Miembro de Colegio Profesional" o "Estudiante" deberán presentarse las credenciales necesarias oportunamente. La opción "Bonificación" requiere de un código provisto por la Escuela de Gestión.</i></label>
                        <br />
                        <br />
                        <table style="width:100%">
                            <tr>
                                <td class="style1"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact">Categoría arancel:</label></td>
                                
                            </tr>
                            
                            <tr>
                                <td style="width:33%">
                                <select onchange="DisplayLbl(this.value)" style="width:auto;" id="select_arancel" name="select_arancel" title="Arancel" style="margin:auto;border:none; width:99%; margin-bottom:8px; height:23px; font-family:'Trebuchet MS, Arial, Helvetica, sans-serif'; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" class="halfWidth placeholder desplegable">
                                <option></option>
                                <%if (Session["empresaSocia"].ToString() == "true")
                                  { %>
                                <option value="Socio">Socio</option>
                                <%} %>
                                <%else
                                    { %>
                                <option value="NoSocio">No socio</option>
                                <%} %>
                                <option value="Colegio">Colegio profesional</option>
                                <option value="Estudiante">Estudiante</option>
                                <option value="Funcionario">Funcionario Público</option>
                                <option value="Beca">Bonificación</option>
                                </select></td>
                                
                            </tr>
                        </table>
                        <br />
                        <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:200; font-size:20px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Monto: $ <span id="valorMonto"></span></h3>
                        <br />
                        <table style="width:100%">
                            <tr>
                                <td style="width:33%"><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact">Código de promoción (si lo posee):</label></td>
                                <td style="width:79%"><input style="margin:auto;border:none; width:99%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="codigoProm" name="codigoProm" title="Código de promoción" class="NoRequerido" type="text" placeholder="Código " value="" /></td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        
                        <div id="divPorcentajes">
                            <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:200; font-size:16px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Fuente de financiamiento: </h3>
                            <table>
                            <tr><td><input id="particular" name="particular" value="1" type="checkbox" onclick="activarP()" /><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="particular">Particular&nbsp; </label>&nbsp;
                            <input style="margin:auto;border:none; width:10%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="porcentaje_part" name="porcentaje_part" title="% Particular" class="NoRequerido" type="text" placeholder="% " disabled="disabled" onkeypress="return validarKey(event);"/><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="porcentaje_part"> %</label>&nbsp;
                                <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuil_fact">&nbsp; &nbsp;CUIL </label><input style="margin:auto;border:none; width:21%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="Cuil_fact" name="Cuil_fact" title="Cuil" class="NoRequerido" type="text" placeholder="Cuil *" disabled="disabled"/>
                            </td></tr></table>
                            <table style="width:100%"><tr><td style="width:50%">
                            <input id="empresa" name="empresa" value="1" type="checkbox" onclick="activarE()"/><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" >Empresa&nbsp;&nbsp;&nbsp; </label>
                            &nbsp;<input style="margin:auto;border:none; width:14%; margin-bottom:8px; height:23px; font-size:12px; line-height:27px; text-indent:4px; display:inline-block;" id="porcentaje_empresa" name="porcentaje_empresa" title="% Empresa" class="NoRequerido" type="text" placeholder="% "  disabled="disabled" onkeypress="return validarKey(event);"/><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="porcentaje_empresa"> %</label>
                            <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact">&nbsp;&nbsp;&nbsp; CUIT </label><input style="margin:auto;border:none; width:29%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="Cuit_fact" name="Cuit_fact" title="Cuit" class="NoRequerido" type="text" placeholder="Cuit *" disabled="disabled"/>
                            </td>
                            <td>
                            <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact">Razón social: </label><input style="margin:auto;border:none; width:70%; margin-bottom:8px; height:23px; font-size:12px; line-height:27px; text-indent:4px; display:inline-block;" id="razon_fact" name="razon_fact" title="Razón social" class="NoRequerido" type="text" placeholder="Razón social *" disabled="disabled"/>
                            </td></tr></table>
                            </div>
                            <table>
                                <tr>
                                     <td class="style1">
                                        <label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="Cuit_fact">¿Necesita documentación para generar el pago del arancel? </label>
                                        <select id="ordenCompra" name="ordenCompra">
                                            <option></option>
                                            <option>SI</option>
                                            <option>NO</option>
                                        </select>
                                     </td> 
                                   
                                </tr>
                            </table>
                            <br />
                            <br />
                            <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:200; font-size:16px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Modo de pago: </h3>
                            <table style="width:100%">
                                <tr>
                                    <td style="width:33%">
                                        <table style="width:100%">
                                            <tr>
                                                <td ><input id="pagoOnline" name="pagoOnline" value="1" type="checkbox" onclick="PagoO()"/><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" >Pago 
                                                    a través de PayU (ex DineroMail)</label></td>
                                           </tr>
                                            <tr id="trPagoCamara"><td><input id="pagoCamara" name="pagoCamara" value="1" type="checkbox" onclick="PagoC()" /><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" >Pago personalmente en la Cámara </label></td></tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table style="width:100%">
                                            <tr>
                                                <td><label style="margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:12px; line-height:14px; color:#BDBDBD; max-width:100px; margin-bottom:14px;" for="Cuil_fact">Se informa que, de acuerdo a lo dispuesto en el inciso k) del apartado “A” del Anexo I de la Resolución General (AFIP) 1415, las entidades comprendidas en ciertos incisos de la ley del Impuesto a las Ganancias, se encuentran exceptuadas de emitir facturas. La Cámara está incluida en uno de esos incisos. Esta exclusión se debe a que la Cámara, como esas empresas, está exenta tanto en el impuesto a las ganancias como en el impuesto al valor agregado. No existe la obligación para la Cámara de emitir facturas, de acuerdo a las normas de la AFIP.La Cámara Argentina de la Construcción remite, entonces, un comprobante, a efectos de facilitar su administración y la de sus asociados y proveedores o clientes, sin incurrir por ello en ningún tipo de falta u omisión formal sobre la facturación. Por otro lado, el receptor no se ve perjudicado por la recepción de este comprobante.</label></td>
                                           </tr>
                                       </table>
                                   </td>
                               </tr>
                           </table> 
                        <br />
                    </div>
                    
                <br/>
                <br/>
                <input type="hidden" id="hidden_disabled" name="hidden_disabled" class="NoRequerido" value="<%=ViewData["READONLY"]%>" />
                <input type="hidden" id="hidden_txt_cuit" name="hidden_txt_cuit" value="" class="NoRequerido"/>

                <input type="hidden" id="Socio" name="hidden_txt_cuit" value="<%=Session["costoCursoSocio"] %>" class="NoRequerido"/>
                <input type="hidden" id="SocioSede" name="hidden_txt_cuit" value="<%=Session["costoCursoSocioSede"] %>" class="NoRequerido"/>
                <input type="hidden" id="NoSocio" name="hidden_txt_cuit" value="<%=Session["costoCursoNoSocio"] %>" class="NoRequerido"/>
                <input type="hidden" id="Estudiante" name="hidden_txt_cuit" value="<%=Session["costoCursoEstudiante"] %>" class="NoRequerido"/>
                <input type="hidden" id="Colegio" name="hidden_txt_cuit" value="<%=Session["costoCursoColegio"] %>" class="NoRequerido"/>
                <input type="hidden" id="Funcionario" name="hidden_txt_cuit" value="<%=Session["costoCursoFuncionario"] %>" class="NoRequerido"/>
                <input type="hidden" id="CodigoEvento" name="hidden_txt_cuit" value="<%=ViewData["codigoEvento"] %>" class="NoRequerido"/>

                <input style="cursor:pointer" type="submit" id="btnInscribir" value="Continuar" class="system-color-btn estiloBoton" />
                <br />
                <br />
                <%if (Session["cursoGratis"].ToString() == "si")
                  { %>
                <h3 id="h3_pagina1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 2/3</h3>
				<%} %>
                <%else
                    { %>
                    <h3 id="h1" style="text-align:center;margin:auto; font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">Página 3/4</h3>
                <%} %>	
				</form>
        </div>
<script type="text/javascript">
    if (document.getElementById("hidden_disabled").value == "true") {
        var valor = document.getElementById("txt_cuit").value;

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
        document.getElementById("hidden_txt_cuit").value = valor;
    }

    

</script>

    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MetaContent" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptContent" runat="server">
<style type="text/css">
    .estiloBoton
    {
        margin:auto;
        width:100%; 
        border-style: none; 
        border-color: inherit; 
        border-width: medium; 
        background-color:White !important; 
        font-family: 'Roboto Condensed', sans-serif; 
        /*
        font-size:14px; 
        line-height:16px; 
        color:Gray; 
        padding:6px 15px; 
        display:inline-block; 
        -webkit-transition: all 0.3s ease; 
        -moz-transition: all 0.3s ease; 
        -o-transition: all 0.3s ease; 
        transition: all 0.3s ease; 
        height: 52px;
        */
    }
</style>
</asp:Content>
