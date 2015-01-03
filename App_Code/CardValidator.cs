using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CardValidator
/// </summary>
/// 

public enum CardType
{
    MasterCard, BankCard, Visa, AmericanExpress, Discover, DinersClub, JCB
};

public sealed class CardValidator
{
    private CardValidator() { } // static only

    public static bool Validate(CardType cardType, string cardNumber)
    {
        byte[] number = new byte[16]; // number to validate

        // Remove non-digits
        int len = 0;
        for (int i = 0; i < cardNumber.Length; i++)
        {
            if (char.IsDigit(cardNumber, i))
            {
                if (len == 16) return false; // number has too many digits
                number[len++] = byte.Parse(cardNumber[i].ToString());
            }
        }

        // Validate based on card type, first if tests length, second tests prefix
        switch (cardType)
        {
            case CardType.MasterCard:
                if (len != 16)
                    return false;
                if (number[0] != 5 || number[1] == 0 || number[1] > 5)
                    return false;
                break;

            case CardType.BankCard:
                if (len != 16)
                    return false;
                if (number[0] != 5 || number[1] != 6 || number[2] > 1)
                    return false;
                break;

            case CardType.Visa:
                if (len != 16 && len != 13)
                    return false;
                if (number[0] != 4)
                    return false;
                break;

            case CardType.AmericanExpress:
                if (len != 15)
                    return false;
                if (number[0] != 3 || (number[1] != 4 && number[1] != 7))
                    return false;
                break;

            case CardType.Discover:
                if (len != 16)
                    return false;
                if (number[0] != 6 || number[1] != 0 || number[2] != 1 || number[3] !=  1)
                    return false;
                break;

            case CardType.DinersClub:
                if (len != 14)
                    return false;
                if (number[0] != 3 || (number[1] != 0 && number[1] != 6 && number[1]    != 8)
                   || number[1] == 0 && number[2] > 5)
                    return false;
                break;

            case CardType.JCB:
                if (len != 16 && len != 15)
                    return false;
                if (number[0] != 3 || number[1] != 5)
                    return false;
                break;

        }

        // Use Luhn Algorithm to validate
        int sum = 0;
        for (int i = len - 1; i >= 0; i--)
        {
            if (i % 2 == len % 2)
            {
                int n = number[i] * 2;
                sum += (n / 10) + (n % 10);
            }
            else
                sum += number[i];
        }
        return (sum % 10 == 0);
    }
}