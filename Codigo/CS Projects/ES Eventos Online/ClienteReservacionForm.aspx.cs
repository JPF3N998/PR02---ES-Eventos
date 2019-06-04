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
        public string currentUser;
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

        public void updateGrid()
        {
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
                MessageBox.CamposVacios();
            }
            else
            {
                try {
                    SqlConnection con = LoginForm.con;
                    System.Diagnostics.Debug.WriteLine(currentUser);
                    SqlCommand cmd = new SqlCommand("spReservar", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@usuario", SqlDbType.NVarChar).Value = currentUser.ToString();
                    cmd.Parameters.Add("@idPaquete", SqlDbType.Int).Value = Int32.Parse(idPaqueteGot);
                    cmd.Parameters.Add("@fecha", SqlDbType.NVarChar).Value = fechaGot;
                    cmd.Parameters.Add("@horaInicio", SqlDbType.NVarChar).Value = horaInicioGot;
                    cmd.Parameters.Add("@horaFin", SqlDbType.NVarChar).Value = horaFinGot;
                    cmd.Parameters.Add("@exito", SqlDbType.Bit).Direction = ParameterDirection.Output;
                    cmd.Parameters.Add("@success", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    // Valor de retorno importante
                    int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                    System.Diagnostics.Debug.WriteLine("spReservar: " + returnValue.ToString());
                    if (returnValue == 0)
                    {
                        MessageBox.Show("Reservacion establecida");
                        updateGrid();
                    }
                    else if (returnValue == -1)
                    {
                        MessageBox.Show("Paquete no disponible en el horario seleccionado");
                    }
                    else
                    {
                        MessageBox.Show("No se puedo establecer la reservacion");
                    }
                }catch(Exception){
                    MessageBox.Show("Datos invalidos");
                }
                
                
            }
        }

        protected void cancelarBtn_Click(object sender, EventArgs e)
        {
            String idReservacionGot = this.idReservacionInput.Text;
            if (idReservacionGot.Length == 0 )
            {
                MessageBox.Show("Campo vacio");
            }
            else
            {
                try {
                    SqlConnection con = LoginForm.con;
                    SqlCommand cmd = new SqlCommand("spCancelarReservacion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = currentUser;
                    cmd.Parameters.Add("@idReservacion", SqlDbType.Int).Value = Int32.Parse(idReservacionGot);
                    cmd.Parameters.Add("@success", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                    System.Diagnostics.Debug.WriteLine("spCancelarReservacion: " + returnValue.ToString());
                    if (returnValue == 0)
                    {
                        MessageBox.Show("Se cancelo la reservacion " + idReservacionGot + " exitosamente");
                        updateGrid();
                    }
                    if (returnValue == -2)
                    {
                        MessageBox.Show("No se puede cancelar la reservacion, hace falta menos de una semana");
                    }
                    else
                    {
                        MessageBox.Show("No se pudo cancelar la reservacion " + idReservacionGot);

                    }
                    con.Close();
                }
                catch (Exception) {
                    MessageBox.Show("Dato ingresado invalido");
                }
                
            }
        }
    }
}