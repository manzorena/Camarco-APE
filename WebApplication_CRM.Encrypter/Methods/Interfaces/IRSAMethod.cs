namespace WebApplication_CRM.Encrypter.Methods.Interfaces
{
    public interface IRSAMethod
    {
        /// <summary>
        /// Encrypt input with RSA Method.
        /// </summary>
        /// <param name="strText"></param>
        /// <returns></returns>
        string Encrypt(string strText);

        /// <summary>
        /// Decrypt input with RSA Method.
        /// </summary>
        /// <param name="strText"></param>
        /// <returns></returns>
        string Decrypt(string strText);
    }
}
