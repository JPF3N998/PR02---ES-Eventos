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
    public partial class ClienteReservacionForm : System.Web.UI.Page
    {
        string currentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            currentUser = Session["user"].ToString();
            this.clientLbl.Text = currentUser;
            SqlConnection con = LoginForm.con;

            //Llenado de la tabla de reservaciones
            DataTable registrodeReservaciones = new DataTable();
            SqlDataAdapter sqlDa = new SqlDataAdapter("spVerReservaciones", con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@username", currentUser);
            sqlDa.Fill(registrodeReservaciones);
            this.gridViewReservaciones.DataSource = registrodeReservaciones;
            this.gridViewReservaciones.DataBind();
            con.Close();
        }

        protected void backBtn_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("ClientePortal.aspx");
        }

        protected void filterBtn_Click(object sender, EventArgs e)
        {
            if (this.filterTextBox.Text == "")
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
                sqlDa.SelectCommand.Parameters.AddWithValue("@nombreRecurso", this.filterTextBox.Text);
                sqlDa.Fill(registrodeReservacionesFiltradas);

                con.Close();
                if (registrodeReservacionesFiltradas.Rows.Count <= 0)
                {
                    MessageBox.Show("El recurso " + this.filterTextBox.Text + " no existe");
                }
                else
                {
                    this.gridViewReservaciones.DataSource = registrodeReservacionesFiltradas;
                    this.gridViewReservaciones.DataBind();
                }
            }
        }

        protected void reservarBtn_Click(object sender, EventArgs e)
        {
            //Variables para almacenar los strings provenientes de los text boxes
            string idPaqueteGot,fechaGot, horaInicioGot, horaFinGot;

            idPaqueteGot = this.idPaqueteInput.Text;
            fechaGot = this.inputFecha.Text;
            horaInicioGot = this.inputHoraInicio.Text;
            horaFinGot = this.horaFinInput.Text;

            if (idPaqueteGot =="" | fechaGot=="" |horaInicioGot=="" | horaFinGot=="")
            {
                MessageBox.Show("Hay campos vacios");
            }
            else
            {
                SqlConnection con = LoginForm.con;

                SqlCommand cmd = new SqlCommand("spReservar", con);
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = Session["user"].ToString(); ;
                cmd.Parameters.Add("@idPaquete", SqlDbType.Int).Value =Int32.Parse(idPaqueteGot);
                cmd.Parameters.Add("@fecha", SqlDbType.NVarChar).Value =fechaGot;
                cmd.Parameters.Add("@horaInicio", SqlDbType.NVarChar).Value =horaInicioGot;
                cmd.Parameters.Add("@horaFin", SqlDbType.NVarChar).Value =horaFinGot;
                cmd.Parameters.Add("@exito", SqlDbType.Bit).Direction = ParameterDirection.ReturnValue;


                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // Valor de retorno importante
                int returnValue = int.Parse(cmd.Parameters["@exito"].Value.ToString());
                
                if (returnValue == 0){
                    DataTable registrodeReservaciones = new DataTable();
                    SqlDataAdapter sqlDa = new SqlDataAdapter("spVerReservaciones", con);
                    sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                    sqlDa.SelectCommand.Parameters.AddWithValue("@username", currentUser);
                    sqlDa.Fill(registrodeReservaciones);
                    this.gridViewReservaciones.DataSource = registrodeReservaciones;
                    this.gridViewReservaciones.DataBind();
                    con.Close();
                    MessageBox.Show("Reservacion establecida");
                    
                }
                else
                    MessageBox.Show("No se puedo establecer la reservacion");
            }
        }
    }
}