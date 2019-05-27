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
    public partial class RegisterAdminForm : System.Web.UI.Page
    {
        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = LoginForm.con;
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("AdministradorPortal.aspx");
        }

        protected void signupBtn_Click(object sender, EventArgs e)
        {
            // Validaciones de todos los datos para mantener la integridad de la base de datos
            String nombreIn = nombreInput.Text;
            if (nombreIn == "" || nombreIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el nombre no puede ser vacio');", true);
                return;
            }

            int cedulaIn;
            if (!int.TryParse(NumCedulaInput.Text, out cedulaIn))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el numero de cedula no puede tener letras ni ser vacio');", true);
                return;
            }

            String emailIn = correoElectronicoInput.Text;
            if (emailIn == "" || emailIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el correo electronico no puede ser vacio');", true);
                return;
            }

            String userNameIn = UsernameInput.Text;
            if (userNameIn == "" || userNameIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el usuario no puede ser vacio');", true);
                return;
            }

            String passwordIn = ContrasennaInput.Text;
            if (passwordIn == "" || passwordIn == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error la contraseña no puede ser vacio');", true);
                return;
            }

            // Se empieza la conexion a la base de datos para crear la cuenta
            SqlCommand cmd = new SqlCommand("spAgregarAdmin", con);
            cmd.CommandType = CommandType.StoredProcedure;

            // Parametros del SP
            cmd.Parameters.Add("@nombreIn", SqlDbType.NVarChar).Value = nombreIn;
            cmd.Parameters.Add("@cedulaIn", SqlDbType.Int).Value = cedulaIn;
            cmd.Parameters.Add("@emailIn", SqlDbType.NVarChar).Value = emailIn;
            cmd.Parameters.Add("@userNameIn", SqlDbType.NVarChar).Value = userNameIn;
            cmd.Parameters.Add("@passwordIn", SqlDbType.NVarChar).Value = passwordIn;
            cmd.Parameters.Add("@result", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

            // Se ejecuta el SP
            con.Open();
            cmd.ExecuteNonQuery();

            // Valor de retorno importante
            int returnValue = int.Parse(cmd.Parameters["@result"].Value.ToString());

            // No dejar la conexion abierta
            con.Close();


            // Se informa al cliente si ocurrio algun error en la creacion de la cuenta o si fue exitosa la creacion
            if (returnValue == -1)
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error la cuenta ya existe');", true);
            else
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('La cuenta fue creada');", true);
            Response.Redirect("LoginForm.aspx");
        }
    }
}