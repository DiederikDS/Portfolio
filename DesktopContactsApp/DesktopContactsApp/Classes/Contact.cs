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

    }
}
