<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Aver</title>
</head>
<body>
    <script type="text/javascript"">

        function validaCuit(CUIT){
            var aMult   = '6789456789';    
            var aMult   = aMult.split('');    
            var sCUIT   = String(CUIT);    
            var iResult = 0;    
            var aCUIT = sCUIT.split('');        
            
            if (aCUIT.length == 11)    {        
            // La suma de los productos        
                for(var i = 0; i <= 9; i++) {
                    iResult += aCUIT[i] * aMult[i];        
                }        
                // El módulo de 11        
                iResult = (iResult % 11);                
                // Se compara el resultado con el dígito verificador        
                return (iResult == aCUIT[10]); 
                
            }
            alert("el CUIT es incorrecto, recuerde que debe ingresar el número sin los guiones");
            document.getElementById("txt_cuit").style.background = "#FE2E64";
                 
            return false;

        }
        function validacion() {
            var CUIT = document.getElementById("txt_cuit").value;

            if (CUIT != '1') {
                return (validaCuit(CUIT));
            }
            else {
                return true;
             }
        }
    </script>
    <div class="consultas-form" id="divDatos" style="display:block; padding:18px 14px; position:relative; margin-bottom:20px; background-color:#4f91cd; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block">
                  
				<form action="/Respuesta" method="post" onsubmit="return validacion()" style="margin-top:18px; border-top:2px solid #FFF; padding-top:9px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif">
                <h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">DATOS DEL CONTACTO</h3>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="nombre" name="nombre" class="halfWidth placeholder" type="text" placeholder="Nombre *" value="<%=ViewData["nombre"] %>" />
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="apellido" name="apellido" class="halfWidth placeholder" type="text" placeholder="Apellido *" value="<%=ViewData["apellido"] %>" />
					<select style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" class="halfWidth placeholder desplegable">
						<option>Sede Central</option>
					</select>
					
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="mail" name="mail" class="halfWidth placeholder" type="text" placeholder="Correo electrónico *" value="<%=ViewData["emailaddress1"] %>" />
					<select style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" class="halfWidth placeholder desplegable">
						<option>DNI</option>
						<option>LI</option>
						<option>LE</option>
					</select>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="DNI" name="DNI" class="halfWidth placeholder" type="text" placeholder="Número Documento *" value="<%=ViewData["DNI"]%>" />
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="telefono" name="telefono" class="halfWidth placeholder" type="text" placeholder="Teléfono particular" value="<%=ViewData["telephone1"] %>"/>
                    
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="celular" name="celular" class="halfWidth placeholder" type="text" placeholder="Teléfono celular *" value="<%=ViewData["mobilephone"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="calle_nom" name="calle_nom" class="halfWidth placeholder" type="text" placeholder="Calle *" value="<%=ViewData["address1_name"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="calle_num" name="calle_num" class="halfWidth placeholder" type="text" placeholder="Número *" value="<%=ViewData["huddle_address1numero"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="piso" name="piso" class="halfWidth placeholder" type="text" placeholder="Piso" value="<%=ViewData["huddle_address1piso"] %>"/>
                    
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="depto" name="depto" class="halfWidth placeholder" type="text" placeholder="Departamento" value="<%=ViewData["huddle_address1departamento"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="ciudad" name="ciudad" class="halfWidth placeholder" type="text" placeholder="Ciudad" value="<%=ViewData["address1_city"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="rol" name="rol" class="halfWidth placeholder" type="text" placeholder="Rol/Cargo/Función" value="<%=ViewData["jobtitle"] %>"/>					
				
				
				<h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">DATOS DE LA EMPRESA</h3>
				
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;"id="txt_razon" name="txt_razon" class="halfWidth placeholder" type="text" placeholder="Razón social *" value="<%=ViewData["nameEmpresa"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="txt_cuit" name="txt_cuit" class="halfWidth placeholder" type="text" placeholder="CUIT *" value="<%=ViewData["sic"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="txt_telEmpresa" name="txt_telEmpresa" class="halfWidth placeholder" type="text" placeholder="Teléfono" value="<%=ViewData["telefonoEmpresa"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="txt_mailEmpresa" name="txt_mailEmpresa" class="halfWidth placeholder" type="text" placeholder="Correo Electrónico" value="<%=ViewData["mailEmpresa"] %>"/>
					<select style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" name="select_Socio" class="halfWidth placeholder desplegable">
                        <%if (ViewData["accountnumber"] != "")
                          {  %>
						    <option selected="selected">Socio</option>
						    <option>No Socio</option>
                        <%} %>
                        <%else 
                          {  %>
						    <option>Socio</option>
						    <option selected="selected">No Socio</option>
                        <%} %>

					</select>
                    
					<input id="pyme" name="pyme" value="1" type="checkbox"><label style=" font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:14px; line-height:29px; color:#FFF; max-width:100px; margin-bottom:14px;" for="pyme"><strong>ES PYME </strong></label>
                    </br>
					
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="calleEmp_nom" name="calleEmp_nom" class="halfWidth placeholder" type="text" placeholder="Calle" value="<%=ViewData["dirEmpresa"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="calleEmp_num" name="calleEmp_num" class="halfWidth placeholder" type="text" placeholder="Número" value="<%=ViewData["huddle_numero"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="emp_piso" name="emp_piso" class="halfWidth placeholder" type="text" placeholder="Piso" value="<%=ViewData["huddle_piso"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="emp_dpto" name="emp_dpto" class="halfWidth placeholder" type="text" placeholder="Departamento" value="<%=ViewData["huddle_departamento"] %>"/>
                    
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="emp_ciudad" name="emp_ciudad" class="halfWidth placeholder" type="text" placeholder="Ciudad" value="<%=ViewData["ciudadEmpresa"] %>"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="emp_pais" name="emp_pais" class="halfWidth placeholder" type="text" placeholder="Pais" value="<%=ViewData["new_pais"] %>"/>
				
				<h3 style="font-family: 'Roboto Condensed', sans-serif; font-weight:400; font-size:25px; line-height:29px; color:#FFF; max-width:520px; margin-bottom:14px;">RESPONSABLE RECURSOS HUMANOS</h3>
				
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="resp_nombre" class="halfWidth placeholder" type="text" placeholder="Nombre"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="resp_apellido" class="halfWidth placeholder" type="text" placeholder="Apellido"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="resp_tel" class="halfWidth placeholder" type="text" placeholder="Teléfono"/>
					<input style="border:none; width:33%; margin-bottom:8px; height:23px; font-family:"Trebuchet MS", Arial, Helvetica, sans-serif; font-size:12px; color:#8e8d8d; line-height:27px; text-indent:4px; display:inline-block;" id="resp_mail" class="halfWidth placeholder" type="text" placeholder="Correo Electrónico"/>
				</br>
                </br>
                <input style="width:100%; border-style: none; border-color: inherit; border-width: medium; background-color:White !important; font-family: 'Roboto Condensed', sans-serif; font-size:14px; line-height:16px; color:Gray; padding:6px 15px; display:inline-block; -webkit-transition: all 0.3s ease; -moz-transition: all 0.3s ease; -o-transition: all 0.3s ease; transition: all 0.3s ease; height: 52px;" 
                    type="submit" id="btnInscribir" value="Inscribirse" class="system-color-btn" />
					
				</form>
                </div>
</body>
</html>
