using System;
using System.Security.Cryptography;
using System.Text;
using WebApplication_CRM.Encrypter.Methods.Interfaces;

namespace WebApplication_CRM.Encrypter.Methods.Implementations
{
    public class RSAMethod : IRSAMethod
    {
        public string Encrypt(string strText)
        {
            string publicKey = "<RSAKeyValue><Modulus>4VVtHBiT30Avdgkz/Zr3LzsoxAGvH/qYYj1b0rRD2n4Cipvy6BJqSHoUe546j61XCIt+ZT8qpZEHvNvRw9Q2gex0sXF8u1l/gdDL3zpuRwg7uXqj4muP01JNHWqITcOPeMk50/7u5tgLBWkk0KncphBL0jqSVZPE1TYCpNQKC6WoWC/zytlHMIt7sDw1NPWJzp2XKNRsOZJ8JPkRPvh8hEBjbrTB+DoV3G0cvcPDocnhY+AnW3gFPIGIlSbzCOVLH+QlCr96OSXao4PjO9YmMYYEC0Uv0e44FWxF0vfvuZRTJex8oDVMRJHi4sPBs3LBv2LiUfMyuNbNRJi5qkmHtQ==</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>";

            var testData = Encoding.UTF8.GetBytes(strText);

            using (var rsa = new RSACryptoServiceProvider())
            {
                try
                {
                    // client encrypting data with public key issued by server                    
                    rsa.FromXmlString(publicKey.ToString());

                    var encryptedData = rsa.Encrypt(testData, false);
                    var base64Encrypted = Convert.ToBase64String(encryptedData);

                    return base64Encrypted;
                }
                finally
                {
                    rsa.PersistKeyInCsp = false;
                }
            }
        }

        public string Decrypt(string strText)
        {
            string privateKey = "<RSAKeyValue><Exponent>AQAB</Exponent><Modulus>4VVtHBiT30Avdgkz/Zr3LzsoxAGvH/qYYj1b0rRD2n4Cipvy6BJqSHoUe546j61XCIt+ZT8qpZEHvNvRw9Q2gex0sXF8u1l/gdDL3zpuRwg7uXqj4muP01JNHWqITcOPeMk50/7u5tgLBWkk0KncphBL0jqSVZPE1TYCpNQKC6WoWC/zytlHMIt7sDw1NPWJzp2XKNRsOZJ8JPkRPvh8hEBjbrTB+DoV3G0cvcPDocnhY+AnW3gFPIGIlSbzCOVLH+QlCr96OSXao4PjO9YmMYYEC0Uv0e44FWxF0vfvuZRTJex8oDVMRJHi4sPBs3LBv2LiUfMyuNbNRJi5qkmHtQ==</Modulus><P>4bnJJxNTv7Tf0b+k8/4uPGgWb0mXPzH86VcHusTmjlQXxYVAsNq8D/8fcBVdQTnPACoOKV1XJnGtZchUACss/uNhiZG2/9/UW5ulKMtcssMm+ks90+aeAuhzqylwrVzqFMp1i4qQLhTTIb01Z1YKIV6NpDtiDagZBThiDSnRLr8=</P><Q>/44uJarcURFI2mA2JjdiOiY0Z0zY/UBSg7YY9fdVcAr3JalLUeH0yVft5ZHVBGv8X1G6z9RAOqGeSdcpROoesVjeTYfXiKpojJH3Fmqy1YluW30KZO6kSsC86QmYarMUGmFcAXCfxxJc4lVFO3FB7WxSKfVIkV+75LVCTSw6Wos=</Q><DP>tAN/CNuf+Y3cxSCKA0+dPe1gnuXYabyKzufqMSegGrezsYEgYyo9uqAiSTewhDj+/UmMu65Ft1IHD9ngK7ZDDw71FUoQ4CR37YrF/y+XQLTjm85vg1Myhm0s+b51rrwfre78KQmbDDTtX8XOFhgGwi/u05/MBcoeEgyyHX9Q5G8=</DP><DQ>7bkxLFD4iWDuyFVficVTVoxbiwxtfYfsOiGWrpfZnlRU+2+0ZQMwVmu5HSi/Y1GgfnrksJfc962INWA1P6oZyxfEE5Md6D+86aaOlwfCO+mQAwMaPDHSGseX85+9bOQQ+0k98Qj3WJO4W8K+mEEO9vEgrW9ChhjsDCChAHD4B2k=</DQ><InverseQ>PpghQKiNOWzzhTMT0KTzwj96W/n0g947oTTOUmkzWxiLccXfSa9GCHkSSFCZnqBWKXvG8BD2yMUNhMkivYg3DBUav167CQbdZ9h/HopN+hxiqs5ErVxpDnthCfFiQnEmkIDRWU18Qks+TqGjut9Pmv+GIMm23oXDxvD7Y4AHQfE=</InverseQ><D>zhmbpbIZNn53qqe6RQEDi9C5daXwrvg/fsOOhAdbdLIC0xLWt0t4qPf4WiUcfSPX0jn8jtCayjr/787DazFj9av4BADATIAMrwjyIChKi2/NaNXypfsp3uiNHhW9vBrd1GWBHhU0IDKEyhskkDJ9XerT3uKxy9JPm5A+FNLYqVLQlVar/FmdKutb3DvlPKoPVKsb9gnq5X/Bg1bm101et9gqm8xpNSROFdPHvi2vJNjhqw3grG8K16Kn4fKj54acdBBpNe1FcW0hr5QCo0HKU4eMbDsCEZOQ5BQpYBZObY+lMnKGtNJQntBQwwPOY8L1tc1akSLX63PFo1f7BYt6dQ==</D></RSAKeyValue>";

            using (var rsa = new RSACryptoServiceProvider())
            {
                try
                {

                    // server decrypting data with private key                    
                    rsa.FromXmlString(privateKey);

                    byte[] encryptedBytes = Convert.FromBase64String(strText);
                    var decryptedBytes = rsa.Decrypt(encryptedBytes, false);
                    var decryptedString = Encoding.UTF8.GetString(decryptedBytes);

                    return decryptedString;
                }
                finally
                {
                    rsa.PersistKeyInCsp = false;
                }
            }
        }
    }
}
