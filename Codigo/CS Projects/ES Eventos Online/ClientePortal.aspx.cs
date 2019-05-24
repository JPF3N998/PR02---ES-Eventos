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
    public partial class ClientePortal : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentUser = Session["user"].ToString();
            this.clientLbl.Text =currentUser;
            SqlConnection con = LoginForm.con;

            //Llenado de la tabla de reservaciones
            DataTable registrodeReservaciones = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter("spVerReservaciones", con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@username",currentUser);
            sqlDa.Fill(registrodeReservaciones);
            this.gridViewReservaciones.DataSource = registrodeReservaciones;
            this.gridViewReservaciones.DataBind();

            //Llendao de la tabla de facturas
            DataTable registrodeFacturas = new DataTable();
            SqlDataAdapter sqlDa2 = new SqlDataAdapter("spVerFacturas", con);
            sqlDa2.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa2.SelectCommand.Parameters.AddWithValue("@username",currentUser);
            sqlDa2.Fill(registrodeFacturas);
            this.historialGridView.DataSource = registrodeFacturas;
            this.historialGridView.DataBind();
            con.Close();
        }

        protected void backBtn_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }

        protected void reservarBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("ClienteReservacionForm.aspx");
        }

        protected void filterBtn_Click(object sender, EventArgs e)
        {
            if (this.inputNombreRecurso.Text == "")
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
                sqlDa.SelectCommand.Parameters.AddWithValue("@nombreRecurso", this.inputNombreRecurso.Text);
                sqlDa.Fill(registrodeReservacionesFiltradas);

                con.Close();
                if (registrodeReservacionesFiltradas.Rows.Count <= 0)
                {
                    MessageBox.Show("El recurso " + this.inputNombreRecurso.Text + " no existe");
                }
                else
                {
                    this.gridViewReservaciones.DataSource = registrodeReservacionesFiltradas;
                    this.gridViewReservaciones.DataBind();
                }
            }
        }
    }
}