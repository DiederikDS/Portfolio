using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SQLite;

namespace DesktopContactsApp.Classes
{
    public class Contact
    {
        //Properties that map to columns in the sql database

        //SQL attributes can be defined between "[]" (due to NuGet package sqlite-net-pcl)
        [PrimaryKey, AutoIncrement]
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }

        //We need to override the ToString methode because when reading the database, the listview does not understand how to display complex object and defaults to the ToString methode.
        public override string ToString()
        {
            return $"{Name} - {Email} - {Phone}";
        }

    }
}
