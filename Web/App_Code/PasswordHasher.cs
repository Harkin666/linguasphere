using System.Security.Cryptography;
using System.Text;

namespace Web
{
    public static class PasswordHasher
    {
        public static string Compute(string plainText)
        {
            if (plainText == null)
                plainText = string.Empty;

            using (var sha = SHA256.Create())
            {
                var bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(plainText));
                var sb = new StringBuilder(bytes.Length * 2);
                foreach (var b in bytes)
                    sb.AppendFormat("{0:X2}", b);
                return sb.ToString();
            }
        }
    }
}
