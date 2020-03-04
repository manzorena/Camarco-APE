using Microsoft.Crm.SdkTypeProxy;
using Microsoft.Crm.SdkTypeProxy.Metadata;
using System;
using System.Net;

namespace Microsoft.Crm.Sdk.Utility
{
	public class CrmServiceUtility
	{
		public static CrmService GetCrmService()
		{
			return CrmServiceUtility.GetCrmService(null, null);
		}

		public static CrmService GetCrmService(string organizationName)
		{
			return CrmServiceUtility.GetCrmService(null, organizationName);
		}

		public static CrmService GetCrmService(string crmServerUrl, string organizationName)
		{
			CrmAuthenticationToken token = new CrmAuthenticationToken();
			token.OrganizationName = organizationName;
			CrmService service = new CrmService();
			if (crmServerUrl != null && crmServerUrl.Length > 0)
			{
				service.Url = new UriBuilder(crmServerUrl)
				{
					Path = "//MSCRMServices//2007//CrmService.asmx"
				}.Uri.ToString();
			}
			service.Credentials = CredentialCache.DefaultCredentials;
			service.CrmAuthenticationTokenValue = token;
			return service;
		}

		public static MetadataService GetMetadataService(string crmServerUrl, string organizationName)
		{
			CrmAuthenticationToken token = new CrmAuthenticationToken();
			token.OrganizationName = organizationName;
			MetadataService service = new MetadataService();
			if (crmServerUrl != null && crmServerUrl.Length > 0)
			{
				service.Url = new UriBuilder(crmServerUrl)
				{
					Path = "//MSCRMServices//2007//MetadataService.asmx"
				}.Uri.ToString();
			}
			service.Credentials = CredentialCache.DefaultCredentials;
			service.CrmAuthenticationTokenValue = token;
			return service;
		}

		public static CrmLabel CreateSingleLabel(string label, int langCode)
		{
			CrmNumber crmNumber = new CrmNumber();
			crmNumber.Value = langCode;
			LocLabel locLabel = new LocLabel();
			locLabel.LanguageCode = crmNumber;
			locLabel.Label = label;
			return new CrmLabel
			{
				LocLabels = new LocLabel[]
				{
					locLabel
				}
			};
		}
	}
}
