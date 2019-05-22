using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ES_Eventos_Online
{
    public partial class LoginForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            string userName = userNameInput.Text;
            if (userName == "" || userName == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el nombre de usuario no puede ser vacio');", true);
                return;
            }

            string password = passwordInput.Text;
            if (password == "" || password == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error la contraseña no puede ser vacia');", true);
                return;
            }


            // Esto tiene mis configuraciones para conectarse a mi base de datos tienen que cambiarla para probarla ustedes
            SqlConnection con = new SqlConnection("Data Source=DESKTOP-RSCO601\\SQLEXPRESS;Initial Catalog=ESEventosOnline;Integrated Security=True");
            SqlCommand cmd = new SqlCommand("spAgregarCliente", con);



        }
    }
}