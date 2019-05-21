using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ES_Eventos_Online
{
    public partial class RegisterLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void signupBtn_Click(object sender, EventArgs e)
        {
            bool error = false;
            // Validacion de argumentos para enviarlos a la base de datos
            String nombreIn = nombreInput.Text;
            if (nombreIn == "" || nombreIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el nombre no puede ser vacio');", true);
                error = true;
            }
            //Response.Write("<script>alert('Error el nombre no puede ser vacio')</script>");


            int cedulaIn;
            if (!int.TryParse(NumCedulaInput.Text, out cedulaIn))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el numero de cedula no puede tener letras ni ser vacio');", true);
                error = true;
            }

            String emailIn = correoElectronicoInput.Text;
            if (emailIn == "" || emailIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el correo electronico no puede ser vacio');", true);
                error = true;
            }

            String userNameIn = UsernameInput.Text;
            if (userNameIn == "" || userNameIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el usuario no puede ser vacio');", true);
                error = true;
            }

            String passwordIn = ContrasennaInput.Text;
            if (passwordIn == "" || passwordIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error la contraseña no puede ser vacio');", true);
                error = true;
            }


            if (error)
                return;

            // Esto tiene mis configuraciones para conectarse a mi base de datos tienen que cambiarla para probarla ustedes
            SqlConnection con = new SqlConnection("Data Source=DESKTOP-RSCO601\\SQLEXPRESS;Initial Catalog=ESEventosOnline;Integrated Security=True");
            SqlCommand cmd = new SqlCommand("spAgregarCliente", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@nombreIn", SqlDbType.NVarChar).Value = nombreIn;
            cmd.Parameters.Add("@cedulaIn", SqlDbType.Int).Value = cedulaIn;
            cmd.Parameters.Add("@emailIn", SqlDbType.NVarChar).Value = emailIn;
            cmd.Parameters.Add("@userNameIn", SqlDbType.NVarChar).Value = userNameIn;
            cmd.Parameters.Add("@passwordIn", SqlDbType.NVarChar).Value = passwordIn;
            cmd.Parameters.Add("@result", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

            con.Open();
            cmd.ExecuteNonQuery();

            int returnValue = int.Parse(cmd.Parameters["@result"].Value.ToString());
            con.Close();

            if(returnValue == -1)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error la cuenta ya existe');", true);
            else
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('La cuenta fue creada');", true);



        }
    }
}