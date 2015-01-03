using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Center : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dvCenterDetail_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        gvCenterList.DataBind();
    }

    protected void dvCenterDetail_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        gvCenterList.DataBind();
    }
}