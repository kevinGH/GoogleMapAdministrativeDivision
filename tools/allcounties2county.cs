using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.IO;
using Newtonsoft.Json.Linq;

namespace tools
{
    class allcounties2county
    {
        static void Main(string[] args)
        {

            //JsonTextReader reader = new JsonTextReader(new StreamReader("artists.json"));
            //JsonSerializer se = new JsonSerializer();

            //object parsedData = se.Deserialize(reader);


            using (StreamReader reader = File.OpenText(@"F:\TestCode\GoogleMapDrawAdministrativeDivision\web\tools\counties.json"))
            {
                JObject counties = (JObject)JToken.ReadFrom(new JsonTextReader(reader));
                JArray arraycounties = (JArray)counties["features"];
                
                foreach (JObject item in arraycounties.Children())
                {
                    File.WriteAllText(@"F:\TestCode\GoogleMapDrawAdministrativeDivision\web\tools\" + item["properties"]["County_ID"].ToString() + ".json", item.ToString());
                }
            }

        }
    }
}
