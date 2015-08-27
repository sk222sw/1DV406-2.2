using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace SummerContacts
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("Create",
                "nykontakt",
                "~/Pages/ContactPages/Create.aspx");

            routes.MapPageRoute("Default",
                "",
                "~/Pages/ContactPages/Listing.aspx");
        }
    }
}