using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Configuration;

/// <summary>
/// Summary description for AuthorizeNet
/// </summary>
public  class AuthorizeNet
{
	public AuthorizeNet()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string[] SendTransactionRequest(Dictionary<string, string> parameters)
    {
        // By default, this sample code is designed to post to our test server for
        // developer accounts: https://test.authorize.net/gateway/transact.dll
        // for real accounts (even in test mode), please make sure that you are
        // posting to: https://secure.authorize.net/gateway/transact.dll

        String Islive = ConfigurationManager.AppSettings.Get("AuthorizeNetLive");

        String post_url = ConfigurationManager.AppSettings.Get("LiveURL");

        Dictionary<string, string> post_values = parameters;

        //the API Login ID and Transaction Key must be replaced with valid values
        post_values.Add("x_login", ConfigurationManager.AppSettings.Get("AuthorizeNetLogin"));
        post_values.Add("x_tran_key", ConfigurationManager.AppSettings.Get("AuthorizeNetTransactionKey"));
        post_values.Add("x_delim_data", "TRUE");
        post_values.Add("x_delim_char", "|");
        post_values.Add("x_relay_response", "FALSE");

        /*
         * 
        TEST MODE OVERRIDE even if account setting
        post_values.Add("x_test_request", "FALSE");
        
         */

        //END---BELOW FILED IS OPTIONAL, YOU CAN ALSO IGNORE IT.
        // Additional fields can be added here as outlined in the AIM integration
        // guide at: http://developer.authorize.net

        // This section takes the input fields and converts them to the proper format
        // for an http post.  For example: "x_login=username&x_tran_key=a1B2c3D4"
        String post_string = "";

        foreach (KeyValuePair<string, string> post_value in post_values)
        {
            post_string += post_value.Key + "=" + HttpUtility.UrlEncode(post_value.Value) + "&";
        }
        post_string = post_string.TrimEnd('&');


        // create an HttpWebRequest object to communicate with Authorize.net
        HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(post_url);
        objRequest.Method = "POST";
        objRequest.ContentLength = post_string.Length;
        objRequest.ContentType = "application/x-www-form-urlencoded";

        // post data is sent as a stream
        StreamWriter myWriter = null;
        myWriter = new StreamWriter(objRequest.GetRequestStream());
        myWriter.Write(post_string);
        myWriter.Close();

        // returned values are returned as a stream, then read into a string
        String post_response;
        HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
        using (StreamReader responseStream = new StreamReader(objResponse.GetResponseStream()))
        {
            post_response = responseStream.ReadToEnd();
            responseStream.Close();
        }

        // the response string is broken into an array
        // The split character specified here must match the delimiting character specified above
        string[] response_array = post_response.Split('|');

        return response_array;

    }
}