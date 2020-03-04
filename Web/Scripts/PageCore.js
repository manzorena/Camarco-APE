var PageCore = {
	FromSQLDate: function (date) { return date.substring(8, 10) + '/' + date.substring(5, 7) + '/' + date.substring(0, 4); },
	ShowLightBox: function (div) { $('.lightbox').css('z-index', Number(div.css('z-index')) - 1); $('.lightbox').show(); },
	CloseLightBox: function () { $('.lightbox').hide(); },
	GetRandomToken: function () { var retval = new Array(15); var seed = (new Date()).getTime(); for (var i = 0; i < 15; i++) { retval[i] = String.fromCharCode(Math.floor(Math.random(seed) * 25) + 65); } return retval.join(''); },
	IsEmpty: function (string) { return string.split(' ').join('').length == 0; },
	BasePath: '',
	GetErrors: function (obj) { if (obj.list != null) { var htmlerrors = '<ul>'; for (var i = 0; i < obj.list.length; i++) { htmlerrors += '<li>' + obj.list[i] + '</li>'; } return htmlerrors + '</ul>'; } if (obj.message != null) { return obj.message; } if (obj.text != null) { return obj.text; } return ''; },
	GetFileExtension: function (file) { return file.split('.').pop().toLowerCase(); },
	GetFileName: function (file) { return file.substr(file.lastIndexOf("\\") + 1); },
	Ir: function (url, nueva) { if (nueva == true) { window.open(url); } else { window.location = url; } },
	AjaxPost: function (url, jsondata, callback) { $.ajax({ url: url, type: "POST", data: { data: jsondata }, success: function (data, status, xhr) { callback(data); } }) },
	AjaxPostHTML: function (url, jsondata, callback) { $.ajax({ url: url, type: "POST", data: { data: jsondata }, success: function (data, status, xhr) { callback(data); } }) },
	AjaxPut: function (url, jsondata, callback) { $.ajax({ url: url, type: "PUT", data: { data: jsondata }, success: function (data, status, xhr) { callback(jQuery.parseJSON(data)); } }) },
	AjaxGet: function (url, callback) { $.ajax({ url: url, type: "GET", success: function (data) { callback(data); } }) },
	AjaxDelete: function (url, jsondata, callback) { $.ajax({ url: url, type: "DELETE", data: { data: jsondata }, success: function (data, status, xhr) { callback(jQuery.parseJSON(data)); } }) },
	HideErrorMessages: function () { $('.mensaje-negativo').hide(); },
	TestErrorMessages: function () { var ok = true; $('.mensaje-negativo').each(function () { var assoc = $('#' + $(this).attr('associatedControl')); if (assoc.is("textarea")) { try { var val = tinyMCE.get(assoc.attr("id")).getContent(); } catch (e) { var val = assoc.val(); } } else { var val = assoc.val(); } if (PageCore.IsEmpty(val)) { $(this).show(); ok = false; } }); return ok; },
	ActivateTabs: function () { $('.tabs li').on('click', function () { var prev = $('.tab-active'); var dataKey = prev.attr("data-key"); $('#' + dataKey).hide(); prev.removeClass('tab-active'); dataKey = $(this).attr("data-key"); $('#' + dataKey).show(); $(this).addClass('tab-active'); }); }
};
var Utils = { GetErrors: function (obj) { if (obj.list != null) { var htmlerrors = '<ul>'; for (var i = 0; i < obj.list.length; i++) { htmlerrors += '<li>' + obj.list[i] + '</li>'; } return htmlerrors + '</ul>'; } if (obj.message != null) { return obj.message; } if (obj.text != null) { return obj.text; } return ''; } };
var Session = {
    scopeLogin: true,
    docId: null,
    ShowLogin: function (login, d) {
        this.scopeLogin = login;
        this.docId = d;
        $('#loginForm_TitleLogin').hide();
        $('#loginForm_TitleContenidoExclusivo').hide();
        $('#loginForm_TitleContenidoExclusivoP').hide();
        if (login)
            $('#loginForm_TitleLogin').show();
        else {
            $('#loginForm_TitleContenidoExclusivo').show();
            $('#loginForm_TitleContenidoExclusivoP').show();
        }
        $('#sessionLoginError').hide();
        $("#loginForm").show();
        PageCore.ShowLightBox($("#loginForm"));
    },
    CloseLogin: function () {
        $("#loginForm").hide();
        $("#recoverPass").hide();
        $("#recoverPassOk").hide();
        PageCore.CloseLightBox();
    },
    RecoverShow: function () {
        $("#loginForm").hide();
        $("#recoverPass").show();
    },
    Recover: function () {
        if (PageCore.IsEmpty($('#recoverName').val()) || PageCore.IsEmpty($('#recoverEmpresa').val()) || PageCore.IsEmpty($('#recoverEmail').val())) {
            alert("Debe ingresar todos los campos.");
            return false;
        }
        var that = this;

        $('#recoverPassB').toggleClass("waiting");
        PageCore.AjaxPost("/Session/Recover", $.toJSON({ n: $("#recoverName").val(), e: $("#recoverEmpresa").val(), m: $("#recoverEmail").val() }), function (result) {
            $('#recoverPassB').toggleClass("waiting");
            if (result.status == "ok") {
                $("#recoverPass").hide();
                $('#recoverPassOk').show();
            }
        });
    },
    DoLogin: function () {
if (PageCore.IsEmpty($('#sessionLoginName').val()) || PageCore.IsEmpty($('#sessionLoginPassword').val())) {
            alert("Debe ingresar todos los campos.");
            return false;
        }
        $('#sessionLoginError').hide();
        var that = this;
        $('#loginFormB').toggleClass("waiting");
        PageCore.AjaxPost("/Session/Validate", $.toJSON({ u: $("#sessionLoginName").val(), p: $("#sessionLoginPassword").val() }), function (result) {

            if (result.status == "ok") {
                if (that.scopeLogin)
                    location.reload(true);
                else {
                    $('#loginDownloadForm > iframe').attr("src", '/File/GetPrivateFile?id=' + that.docId);
                    setTimeout(function(){location.reload(true);},2000);
                }
            }
            else { $('#loginFormB').toggleClass("waiting"); $('#sessionLoginErrorMessage').text(result.message); $('#sessionLoginError').show(); }
        });
    }
};