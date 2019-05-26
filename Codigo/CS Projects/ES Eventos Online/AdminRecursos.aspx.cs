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
                    System.Diagnostics.Debug.WriteLine("spEliminarRecurso: "+returnValue.ToString());
                    if (returnValue == 0)
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

        protected void nuevoPaqueteBtn_Click(object sender, EventArgs e)
        {
            if (this.agregarPaquetePart.Visible == false)
            {
                agregarPaquetePart.Visible = true;
            }
            else
                agregarPaquetePart.Visible = false;
        }

        protected void borrarPaqueteBtn_Click(object sender, EventArgs e)
        {
            if (borrarPaquetePart.Visible == true)
            {
                borrarPaquetePart.Visible = false;
            }
            else
                borrarPaquetePart.Visible = true;
        }

        protected void addPaqueteBtn_Click(object sender, EventArgs e)
        {
            string nombreRecursoGot = this.inputRecursoName.Text;
            if (nombreRecursoGot.Equals(""))
            {
                MessageBox.CamposVacios();
            }
            else
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("spAgregarPaquete", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@nombreRecurso",SqlDbType.NVarChar).Value = nombreRecursoGot;
                    cmd.Parameters.Add("@idPaquete", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    int returnValue = Int32.Parse(cmd.Parameters["@idPaquete"].Value.ToString());
                    System.Diagnostics.Debug.WriteLine("spAgregarPaquete: " + returnValue.ToString());
                    if (returnValue == -1)
                    {
                        MessageBox.Show("Recurso " + nombreRecursoGot + " no existe.");

                    }
                    else
                    {
                        MessageBox.Show("Paquete para el recurso "+ nombreRecursoGot + " agregado exitosamente.");
                        this.agregarPaquetePart.Visible = false;
                        
                    }

               }
                catch (Exception)
                {
                    MessageBox.DatosMalos();
                }
            }
        }

        protected void deletePaqueteBtn_Click(object sender, EventArgs e)
        {
            string idPaqueteGot = this.idPaqueteInputDelete.Text;
            if (idPaqueteInputDelete.Equals(""))
            {
                MessageBox.CamposVacios();
            }
            else
            {
                //try
                //{
                    SqlCommand cmd = new SqlCommand("spEliminarPaquete", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@idPaquete", SqlDbType.NVarChar).Value = int.Parse(idPaqueteGot);
                    cmd.Parameters.Add("@success", SqlDbType.Bit).Direction = ParameterDirection.ReturnValue;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                    System.Diagnostics.Debug.WriteLine("spBorrarPaquete: " + returnValue.ToString());
                    if (returnValue == -1)
                    {
                        MessageBox.Show("Paquete " + idPaqueteGot + " no existe.");

                    }
                    else
                    {
                        MessageBox.Show("Paquete " + idPaqueteGot + " para el recurso eliminado exitosamente.");
                        this.borrarPaquetePart.Visible = false;

                    }

              //  }
                /*catch (Exception)
                {
                    MessageBox.DatosMalos();
                }*/
            }
        }

        protected void addProductoBtn_Click(object sender, EventArgs e)
        {
            String idPaqueteGot, nombreProductoGot, precioProductoGot;
            idPaqueteGot = this.idPaqueteInput.Text;
            nombreProductoGot = this.nombreProductoInput.Text;
            precioProductoGot = this.precioProductoInput.Text;

            if(idPaqueteGot.Equals("") | nombreProductoGot.Equals("") | precioProductoGot.Equals(""))
            {
                MessageBox.CamposVacios();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("spAgregarProducto", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@idPaquete", SqlDbType.Int).Value = int.Parse(idPaqueteGot);
                cmd.Parameters.Add("@nombreProducto", SqlDbType.NVarChar).Value = nombreProductoGot;
                cmd.Parameters.Add("@precioProducto", SqlDbType.Float).Value = float.Parse(precioProductoGot);
                cmd.Parameters.Add("@success", SqlDbType.Bit).Direction = ParameterDirection.ReturnValue;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                System.Diagnostics.Debug.WriteLine("spAgregarProducto: " + returnValue.ToString());
                if (returnValue == -1)
                {
                    MessageBox.Show("Paquete " + idPaqueteGot + " no existe.");

                }
                else
                {
                    MessageBox.Show("Producto " + nombreProductoGot + " agregado al paquete "+idPaqueteGot+" de manera exitosa");
                    this.agregarProductoPart.Visible = false;

                }
            }
        }

        protected void borrarProductoBtn_Click(object sender, EventArgs e)
        {
            String nombreProductoGot = this.idProductoInput.Text;


            if (nombreProductoGot.Equals(""))
            {
                MessageBox.CamposVacios();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("spEliminarProducto", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@nombreProducto", SqlDbType.NVarChar).Value = nombreProductoGot;
                cmd.Parameters.Add("@success", SqlDbType.Bit).Direction = ParameterDirection.ReturnValue;

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                int returnValue = Int32.Parse(cmd.Parameters["@success"].Value.ToString());
                System.Diagnostics.Debug.WriteLine("spEliminarProducto: " + returnValue.ToString());
                
                if(returnValue == 0)
                {
                    MessageBox.Show("Producto "+nombreProductoGot+" elimado exitosamente");
                    this.borrarProductoPart.Visible = false;
                }
                else
                {
                    MessageBox.Show("Error al eliminar el producto "+nombreProductoGot);

                }
            }
        }

        protected void openProductoSectionBtn_Click(object sender, EventArgs e)
        {
            if (this.agregarProductoPart.Visible==false)
            {
                agregarProductoPart.Visible = true;
            }
            else
            {
                agregarProductoPart.Visible = false;
            }
        }

        protected void openProductoDeleteSectionBtn_Click(object sender, EventArgs e)
        {
            if (this.borrarProductoPart.Visible==false)
            {
                borrarProductoPart.Visible = true;
            }
            else
            {
                borrarProductoPart.Visible = false;
            }
        }
    }
}