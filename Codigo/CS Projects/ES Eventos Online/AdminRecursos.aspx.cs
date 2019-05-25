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
    public partial class AdminRecursos : System.Web.UI.Page
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

        protected void newRecursoBtn_Click(object sender, EventArgs e)
        {
            if(newRecursoPart.Visible == true)
            {
                newRecursoPart.Visible = false;
            }
            else 
                newRecursoPart.Visible = true;
        }

        protected void addRercursoBtn_Click(object sender, EventArgs e)
        {
            String nombreGot, correoGot, telefonoGot, provinciaGot;
            nombreGot = this.nombreInput.Text;
            correoGot = this.correoInput.Text;
            telefonoGot = this.telefonoInput.Text;
            provinciaGot = this.provinciaInput.Text;
            if (nombreGot.Equals("") | correoGot.Equals("") | telefonoGot.Equals("") | provinciaGot.Equals(""))
            {
                MessageBox.Show("Hay campos vacios");
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spAgregarRecurso", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@nombreRecurso", SqlDbType.NVarChar).Value =nombreGot;
                    cmd.Parameters.Add("@correoRecurso", SqlDbType.NVarChar).Value =correoGot;
                    cmd.Parameters.Add("@telefonoRecurso", SqlDbType.NVarChar).Value =telefonoGot;
                    cmd.Parameters.Add("@provinciaRecurso",SqlDbType.NVarChar).Value =provinciaGot;
                    cmd.Parameters.Add("@success", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());

                    System.Diagnostics.Debug.WriteLine("spReservar: " + returnValue.ToString());
                    if (returnValue == 0)
                    {
                        MessageBox.Show("Recurso " + nombreGot + " agregado exitosamente");
                        newRecursoPart.Visible = false;
                    }
                    else if (returnValue == -2)
                    {
                        MessageBox.Show("Recurso "+nombreGot+" ya existe");
                    }
                    else
                        MessageBox.Show("No se pudo agregar el recurso nuevo.");

                }
                catch (Exception)
                {
                    MessageBox.Show("Datos ingresados no son validos");
                }   
            }
        }

        protected void borrarRecursoBtn_Click(object sender, EventArgs e)
        {
            string nombreRecursoGot = this.recursoInputBorrar.Text;
            if (nombreRecursoGot.Equals(""))
            {
                MessageBox.Show("Campo esta vacio");
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spEliminarRecurso", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@nombreRecurso", SqlDbType.NVarChar).Value = nombreRecursoGot;
                    cmd.Parameters.Add("@success", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                    if(returnValue == 0)
                    {
                        MessageBox.Show("Recurso "+nombreRecursoGot+" eliminado exitosamente.");
                        this.deleteRecursoPart.Visible = false;
                    }
                    else
                    {
                        MessageBox.Show("Recurso " + nombreRecursoGot + " no existe.");

                    }
                }
                catch (Exception)
                {
                    MessageBox.Show("Datos ingresados invalidos");
                }
            }
        }

        protected void deleteRecursoBtn_Click(object sender, EventArgs e)
        {
            if(deleteRecursoPart.Visible == true)
            {
                deleteRecursoPart.Visible = false;
            }
            else
            {
                deleteRecursoPart.Visible = true;
            }
        }
    }
}