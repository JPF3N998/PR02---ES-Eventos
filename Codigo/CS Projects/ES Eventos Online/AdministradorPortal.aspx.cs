using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ES_Eventos_Online
{
    public partial class AdministradorPortalForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = LoginForm.con;

            //Llenado de la tabla de reservaciones
            DataTable registrodeReservaciones = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter("spVerReservaciones", con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@username", Session["user"].ToString());
            sqlDa.Fill(registrodeReservaciones);
            this.reservacionesGridView.DataSource = registrodeReservaciones;
            this.reservacionesGridView.DataBind();

            //Llendao de la tabla de facturas
            DataTable registrodeFacturas = new DataTable();
            SqlDataAdapter sqlDa2 = new SqlDataAdapter("spVerFacturas", con);
            sqlDa2.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa2.SelectCommand.Parameters.AddWithValue("@username", Session["user"].ToString());
            sqlDa2.Fill(registrodeFacturas);
            this.historialGridView.DataSource = registrodeFacturas;
            this.historialGridView.DataBind();
            con.Close();
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void registerAdminBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterAdminForm.aspx");
        }

        protected void filterBtn_Click(object sender, EventArgs e)
        {
            if (this.filterReservacionesTextBox.Text == "")
            {
                MessageBox.Show("Campo vacio");
            }
            else
            {
                SqlConnection con = LoginForm.con;
                DataTable registrodeReservacionesFiltradas = new DataTable();
                SqlDataAdapter sqlDa = new SqlDataAdapter("spFiltrarReservaciones", con);
                sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlDa.SelectCommand.Parameters.AddWithValue("@username", Session["user"].ToString());
                sqlDa.SelectCommand.Parameters.AddWithValue("@nombreRecurso", this.filterReservacionesTextBox.Text);
                sqlDa.Fill(registrodeReservacionesFiltradas);
                
                con.Close();
                if (registrodeReservacionesFiltradas.Rows.Count <= 0)
                {
                    MessageBox.Show("El recurso "+this.filterReservacionesTextBox.Text+" no existe");
                }
                else
                {
                    this.reservacionesGridView.DataSource = registrodeReservacionesFiltradas;
                    this.reservacionesGridView.DataBind();
                }
            }
        }

        protected void resourcesBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminRecursos.aspx");
        }
    }
}