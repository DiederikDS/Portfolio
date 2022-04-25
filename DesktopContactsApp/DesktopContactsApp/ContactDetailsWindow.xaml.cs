using DesktopContactsApp.Classes;
using SQLite;
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

namespace DesktopContactsApp
{
    /// <summary>
    /// Interaction logic for ContactDetailsWindow.xaml
    /// </summary>
    public partial class ContactDetailsWindow : Window
    {

        Contact contact;
        public ContactDetailsWindow(Contact contact)
        {
            InitializeComponent();

            //we make sure that when this window is prompted, it is near the mainwindow on the screen.
            Owner = Application.Current.MainWindow;
            WindowStartupLocation = WindowStartupLocation.CenterOwner;

            this.contact = contact;

            //Set the selected contact information to the corresponding textboxes in the ContactDetailsWindow.
            nameTextBox.Text = contact.Name;
            phoneTextBox.Text = contact.Phone;
            emailTextBox.Text = contact.Email;

        }

        private void Update_Button_Click(object sender, RoutedEventArgs e)
        {
            //Set the adjusted contact infromation from the textboxes in the ContactDetailsWindow to the selected contact.
            contact.Name = nameTextBox.Text;
            contact.Email = emailTextBox.Text;
            contact.Phone = phoneTextBox.Text;

            using (SQLiteConnection connection = new SQLiteConnection(App.databasePath))
            {
                //Create the contact table at the connection location.
                connection.CreateTable<Contact>();
                connection.Update(contact);
            }

            Close();
        }

        private void Delete_Button_Click(object sender, RoutedEventArgs e)
        {
            using (SQLiteConnection connection = new SQLiteConnection(App.databasePath))
            {
                //Create the contact table at the connection location.
                connection.CreateTable<Contact>();
                connection.Delete(contact);
            }

            Close();
        }
    }
}
