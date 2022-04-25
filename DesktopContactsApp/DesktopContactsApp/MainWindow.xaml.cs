using DesktopContactsApp.Classes;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace DesktopContactsApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        List<Contact> contacts;

        public MainWindow()
        {
            InitializeComponent();

            contacts = new List<Contact>();

            ReadDataBase();
        }

        //Makes a NewContactWindow appear when the button "New Contact" is clicked.
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            NewContactWindow newContactWindow = new NewContactWindow();
            newContactWindow.ShowDialog();
            ReadDataBase();
        }

        void ReadDataBase()
        {

            using (SQLite.SQLiteConnection connection = new SQLite.SQLiteConnection(App.databasePath))
            {
                //We need to have at least 1 table to read from or the application will crash (ReadDatabase is called in the constructor of the MainWindow)
                connection.CreateTable<Contact>();
                //we create a list of Contact objects read from the contact table.
                contacts = (connection.Table<Contact>().ToList()).OrderBy(c => c.Name).ToList();
            }

            if (contacts != null)
            {

                contactListView.ItemsSource = contacts;

            }
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox searchTextBox = sender as TextBox;

            var filteredList = contacts.Where(c => c.Name.ToLower().Contains(searchTextBox.Text.ToLower())).ToList();

            contactListView.ItemsSource = filteredList;

        }

        private void contactListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Contact selectedContact = (Contact)contactListView.SelectedItem;

            if (selectedContact != null)
            {
                ContactDetailsWindow contactDetailsWindow = new ContactDetailsWindow(selectedContact);
                contactDetailsWindow.ShowDialog();
            }

            ReadDataBase();

        }
    }
}
