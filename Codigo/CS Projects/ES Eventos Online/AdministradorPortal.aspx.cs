using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ES_Eventos_Online
{
    public partial class AdministradorPortalForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void registerAdminBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAdminForm.aspx");
        }
    }
}