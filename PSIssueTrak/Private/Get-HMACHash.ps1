Add-Type -TypeDefinition @'
    using System;
    using System.Text;
    using System.Security.Cryptography;

    public class HMACHash
    {
        public static String ComputeHMACHash(String APIKey, String messageToBeHashed)
        {
            String hashText = null;
            Byte[] APIKeyBytes = Encoding.UTF8.GetBytes(APIKey);

            using (HMACSHA512 hmacHashGenerator = new HMACSHA512(APIKeyBytes))
            {
                Byte[] messageToBeHashedBytes = Encoding.UTF8.GetBytes(messageToBeHashed);
                Byte[] hashedMessageBytes = hmacHashGenerator.ComputeHash(messageToBeHashedBytes);
                hashText = Convert.ToBase64String(hashedMessageBytes);
            }

            return hashText;
        }
    }
'@

function Get-HMACHash
{
    param([string] $APIKey, [string] $messageToBeHashed)

    return [HMACHash]::ComputeHMACHash($APIKey, $messageToBeHashed)
}