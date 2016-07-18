Add-Type -TypeDefinition @'
    using System;
    using System.Text;
    using System.Security.Cryptography;

    public class HMACHash
    {
        public static String ComputeHMACHash(String hashKey, String messageToBeHashed)
        {
            String hashText = null;
            Byte[] hashKeyBytes = Encoding.UTF8.GetBytes(hashKey);

            using (HMACSHA512 hmacHashGenerator = new HMACSHA512(hashKeyBytes))
            {
                Byte[] messageToBeHashedBytes = Encoding.UTF8.GetBytes(messageToBeHashed);
                Byte[] hashedMessageBytes = hmacHashGenerator.ComputeHash(messageToBeHashedBytes);
                hashText = Convert.ToBase64String(hashedMessageBytes);
            }

            return hashText;
        }    }'@function Get-HMACHash
{
    param([string] $hashKey, [string] $messageToBeHashed)

    return [HMACHash]::ComputeHMACHash($hashKey, $messageToBeHashed)
}