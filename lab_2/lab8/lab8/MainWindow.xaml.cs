using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Configuration;
using System.Data;

namespace lab8
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        static string connectionString;
        public MainWindow()
        {
            InitializeComponent();
            connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();

                if(Select.Text == String.Empty)
                {
                    MessageBox.Show("Please, fill the field!");
                }
                else
                {
                    SqlDataAdapter da = new SqlDataAdapter("SELECT Name, Country FROM Tours inner join Сountries on Сountries.id = Tours.idCountry where Country='" + this.Select.Text.ToString() + "'", connection);
                    SqlCommandBuilder cd = new SqlCommandBuilder(da);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Сountries....");
                    datarid.ItemsSource = ds.Tables["Сountries...."].DefaultView;
                    Select.Text = "";
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
            }

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                if (Insert.Text == String.Empty)
                {
                    MessageBox.Show("Please, fill the field!");
                }
                else
                {
                    string commandAdd = "INSERT INTO Сountries values ('" + Insert.Text.ToString() + "')";
                    SqlCommand command = new SqlCommand(commandAdd, connection);
                    if (command.ExecuteNonQuery() == 1)
                    {
                        MessageBox.Show("Сountry " + Insert.Text + " added.");
                        Insert.Text = "";
                    }
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Сountries", connection);
                    SqlCommandBuilder cd = new SqlCommandBuilder(da);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Сountries....");
                    datarid.ItemsSource = ds.Tables["Сountries...."].DefaultView;
                }
                    
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }


        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();

                if (Delete.Text == String.Empty)
                {
                    MessageBox.Show("Please, fill the field!");
                }
                else
                {
                    string commandDel = "DELETE FROM Сountries WHERE Country='" + Delete.Text.ToString() + "'";
                    SqlCommand command = new SqlCommand(commandDel, connection);
                    if (command.ExecuteNonQuery() == 1)
                    {
                        MessageBox.Show("Country " + Delete.Text.ToString() + " removed.");
                    }

                    Delete.Text = "";
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Сountries", connection);
                    SqlCommandBuilder cd = new SqlCommandBuilder(da);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "Сountries....");
                    datarid.ItemsSource = ds.Tables["Сountries...."].DefaultView;
                }                
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            try
            {
                connection.Open();
                if (UpdateT.Text == String.Empty && UpdateC.Text == String.Empty)
                {

                    MessageBox.Show("Please, fill the fields!");
                }
                else
                {
                    string commandDel = "UPDATE Tours SET Name = '"+ UpdateT.Text.ToString()+ "' FROM Tours inner join Сountries on Tours.idCountry = Сountries.id WHERE Country ='"+UpdateC.Text.ToString()+"'";
                    SqlCommand command = new SqlCommand(commandDel, connection);
                    if (command.ExecuteNonQuery() == 1)
                    {
                        MessageBox.Show("Tour updated.");
                    }
                    UpdateC.Text = "";
                    UpdateT.Text = "";
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                connection.Close();
            }
        }

    }
}