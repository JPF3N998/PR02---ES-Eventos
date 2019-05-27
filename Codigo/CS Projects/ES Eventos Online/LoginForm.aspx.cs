using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
namespace ES_Eventos_Online
{
    public partial class LoginForm : System.Web.UI.Page
    {

        string server = "Data Source=" + Global.configServerName+";Initial Catalog=ESEventosOnline;Integrated Security=True";

        public static string andreyConString = Global.configServerName+";Initial Catalog=ESEventosOnline;Integrated Security=True";
        public  static string fengConString = ConfigurationManager.ConnectionStrings["fengConnectionString"].ConnectionString;
        public static string fengDesktopConString = "Data Source=" + Global.fengDesktopServerName + ";Initial Catalog=ESEventosOnline;Integrated Security=True";

        public static string carlosConString = "Data Source="+Global.carlosServerName + ";Initial Catalog=ESEventosOnline;Integrated Security=True";

        public static SqlConnection feng =new SqlConnection(fengConString);
        public static SqlConnection fengDesktop = new SqlConnection(fengDesktopConString);
        public static SqlConnection andrey = new SqlConnection(andreyConString);
        public static SqlConnection carlos = new SqlConnection(carlosConString);
        //Cambiar aqui segun quien lo este usando
        public static SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
           con = fengDesktop;
           Session["connectionString"] = fengConString;
        }

        protected void pruebaEmails() {
            // Prep
            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");

            // Cuerpo, etc
            mail.From = new MailAddress("iruda2559@gmail.com");
            mail.To.Add("torres.and1313@hotmail.com");
            mail.Subject = "Test Mail";
            mail.Body = "This is for testing SMTP mail from GMAIL";

            // Setup
            SmtpServer.Port = 587;
            SmtpServer.Credentials = new System.Net.NetworkCredential("iruda2559", "JajaSalu2");
            SmtpServer.EnableSsl = true;

            // Envio
            SmtpServer.Send(mail);
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            // Validaciones de todos los datos para mantener la integridad de la base de datos
            string userName = userNameInput.Text;
            if (userName == "" || userName == null)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error el nombre de usuario no puede ser vacio');", true);
                return;
            }

            string password = passwordInput.Text;
            if (password == "" || password == null)
            {
                MessageBox.Show("Error la contraseña no puede ser vacia");
                return;
            }

            
            SqlCommand cmd = new SqlCommand("spLogin", con);
            cmd.CommandType = CommandType.StoredProcedure;

            // Parametros del SP
            cmd.Parameters.Add("@nombreUsuarioInput", SqlDbType.Char).Value = userName;
            cmd.Parameters.Add("@passwordInput", SqlDbType.Char).Value = password;
            cmd.Parameters.Add("@isAdmin", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

            // Se ejecuta el SP
            con.Open();
            cmd.ExecuteNonQuery();

            // Valor de retorno importante
            int returnValue = int.Parse(cmd.Parameters["@isAdmin"].Value.ToString());

            // No dejar la conexion abierta
            con.Close();
            // Se redirecciona de acuerdo al tipo de cuenta que se haya encontrado ADMIN o CLIENTE
            if (returnValue == 1)
            {
                Session["user"] = "admin";
                Response.Redirect("AdministradorPortal.aspx");
            }
            else if (returnValue == 0)
            {
                Session["user"] = userName;
                Response.Redirect("ClientePortal.aspx");
            }
            else
                MessageBox.Show("La cuenta no fue encontrada, verifique sus credenciales");
        }
    }
}