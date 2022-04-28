using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WeatherApp.Model
{

    //This class was made through a Json file (api to get information on a city)
    public class Area
    {
        public int ID { get; set; }

        public string LocalizedName { get; set; }
    }

    public class City
    {
        public int Version { get; set; }
        public string Key { get; set; }
        public string Type { get; set; }
        public int Rank { get; set; }
        public string LocalizedName { get; set; }
        public Area Area { get; set; }
    }
}
