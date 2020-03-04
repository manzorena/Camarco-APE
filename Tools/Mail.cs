using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Text;

namespace Camarco.Tools
{
	public class Mail
	{
		private SmtpClient smtp;

		private MailMessage message;

		public Mail(string Subject)
		{
			if (Subject.Length == 0)
			{
				throw new Exception("Email: Se debe definir el sujeto del mensaje.");
			}
			this.smtp = new SmtpClient();
			this.message = new MailMessage();
			this.message.Priority = MailPriority.High;
			this.message.Subject = Subject;
		}

		public void SetPlaintextBody(string body)
		{
			this.message.IsBodyHtml = false;
			this.message.Body = body;
		}

		public void SetHTMLBody(Dictionary<string, string> ReplaceArray, string File)
		{
			StringBuilder htmlContent = FileManager.GetFileText(File);
			foreach (KeyValuePair<string, string> replaceToken in ReplaceArray)
			{
				htmlContent = htmlContent.Replace("%" + replaceToken.Key + "%", replaceToken.Value);
			}
			this.message.IsBodyHtml = true;
			this.message.Body = htmlContent.ToString();
		}

		public void AddTo(string email)
		{
			this.message.Bcc.Add(new MailAddress(email));
		}

		public void Send()
		{
			if (this.message.Body.Length == 0)
			{
				throw new Exception("Email: No se ha definido un cuerpo del mensaje.");
			}
			if (this.message.Bcc.Count == 0)
			{
				throw new Exception("Email: No se han definido destinatarios del mensaje.");
			}
            this.smtp.UseDefaultCredentials = false;
			this.smtp.Send(this.message);
		}
	}
}
