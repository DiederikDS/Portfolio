using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;
using DesktopContactsApp.Classes;
using SQLite;

namespace DesktopContactsApp
{
    /// <summary>
    /// Interaction logic for NewContactWindow.xaml
    /// </summary>
    public partial class NewContactWindow : Window
    {
        public NewContactWindow()
        {
            InitializeComponent();
        }

        //save contact to database and close window.
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Contact contact = new Contact()
            {
                Name = nameTextBox.Text,
                Email = emailTextBox.Text,
                Phone = phoneTextBox.Text
            };
           
            //the connection only exists during the using statement and is closed automatically (databasePath is defined in the App.xaml.cs)
            using (SQLiteConnection connection = new SQLiteConnection(App.databasePath))
            {
                //Create the contact table at the connection location.
                connection.CreateTable<Contact>();
                connection.Insert(contact);
            }
            
            Close();
        }
    }
}
