using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;

/// <summary>
/// Summary description for messagebox
/// </summary>
public static class messagebox
{
 
    public static void ShowMessageBox(string message)
    {
        if (!string.IsNullOrEmpty(message))
        {
            if (message.EndsWith("."))
                message = message.Substring(0, message.Length - 1);
        }

        StringBuilder sbScript = new StringBuilder(50);

        //Java Script header
        sbScript.Append("<script type='text/javascript'>" + Environment.NewLine);
        sbScript.Append("// Show messagebox" + Environment.NewLine);
        message = message.Replace("\n", "\\n").Replace("\"", "'");
        sbScript.Append(@"alert( """ + message + @""" );");
        sbScript.Append(@"</script>");

        // Gets the executing web page
        Page currentPage = HttpContext.Current.CurrentHandler as Page;

        // Checks if the handler is a Page and that the script isn't already on the Page
        if (currentPage != null && !currentPage.ClientScript.IsStartupScriptRegistered("ShowMessageBox"))
        {
            currentPage.ClientScript.RegisterStartupScript(currentPage.GetType(), "ShowMessageBox", sbScript.ToString());
        }
    }
}