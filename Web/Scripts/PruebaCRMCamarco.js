try 
{
    var oXML = new XMLHttpRequest();

    oXML.open('GET', "/isv/CrmServiceToolkit/CrmServiceToolkit.js", false);

    oXML.send('');
    eval(oXML.responseText);

    var cantidad = prompt("Cuántos códigos desea crear?", "");
    if (cantidad != null) 
    {
        var idEvento = crmForm.ObjectId;
        var codEvento = crmForm.all.codename.DataValue;

        for (var c = 0; c < cantidad; c++) 
        {
            var randomEnd = "";
            var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            for (var i = 0; i < 5; i++)
                randomEnd += possible.charAt(Math.floor(Math.random() * possible.length));

            var codPromocion = codEvento + "-" + randomEnd;

            var nuevaPromocion = new CrmServiceToolkit.BusinessEntity("new_promocion");
            nuevaPromocion.attributes["new_name"] = codPromocion;
            nuevaPromocion.attributes["new_usado"] = false;
            nuevaPromocion.attributes["new_codigospromocionesid"] = idEvento;

            var createResponse = CrmServiceToolkit.Create(nuevaPromocion);
        }

        alert("Códigos de promociones creados exitosamente");
    }
}
catch (e) {
    alert(e.Description);
}