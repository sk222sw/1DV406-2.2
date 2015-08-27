using SummerContacts.Model;
using SummerContacts.Model.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SummerContacts.Pages.ContactPages
{
    public partial class Create : System.Web.UI.Page
    {

        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public void ContactFormView_InsertItem(Contact contact)
        {
            //ModelState tittar på statusen beträffande DataAnnotations
            //kontra IsValid som kollar valideringskontroller i aspx-filen
            if (ModelState.IsValid)
            {
                try
                {
                    Service.SaveContact(contact);
                    Response.RedirectToRoute("Default");
                    Session["Success"] = true;
                    InsertPlaceHolder.Visible = true;
                    SuccessPlaceHolder.Visible = true;
                }
                catch (Exception)
                {
                    ModelState.AddModelError(String.Empty, "Ett fel inträffade då kontakten skulle läggas till.");
                }
            }
        }

        protected void HideSuccessMessagesButton_Click(object sender, EventArgs e)
        {
            SuccessPlaceHolder.Visible = false;
        }

    }
}