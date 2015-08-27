using SummerContacts.Model;
using SummerContacts.Model.BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SummerContacts
{
    public partial class Default : System.Web.UI.Page
    {

        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IEnumerable<Contact> ContactListView_GetData(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            try
            {
                //return Service.GetContacts();
                //int totalRowCount;
                return Service.GetPageWise(maximumRows, startRowIndex, out totalRowCount);
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Ett fel inträffade vid hämtning av kontakter.");

                //"The out parameter 'totalRowCount' must be assigned to before control leaves the current method.
                totalRowCount = 0;
                return null;
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ContactListView_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
                DeletePlaceHolder.Visible = true;
                SuccessPlaceHolder.Visible = true;
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Ett fel inträffade då kontakten skulle tas bort.");
            }
        }

        public void ContactListView_UpdateItem(int contactId)
        {
            try
            {
                Contact contact = Service.GetContact(contactId);

                if (contact == null)
                {
                    Response.Clear();
                    Response.StatusCode = 404;
                    Response.StatusDescription = "Kontakten hittades inte.";
                    Response.End();
                }

                if (TryUpdateModel(contact))
                {
                    Service.SaveContact(contact);
                    UpdateSuccessPlaceHolder.Visible = true;
                    SuccessPlaceHolder.Visible = true;
                }
            }
            catch (AggregateException ex)
            {
                foreach (var vr in ex.InnerExceptions)
                {
                    ModelState.AddModelError(String.Empty, vr.Message);                    
                }
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Ett fel inträffade då kontakten skulle uppdateras.");
            }
        }

        protected void HideSuccessMessagesButton_Click(object sender, EventArgs e)
        {
            SuccessPlaceHolder.Visible = false;
        }



    }
}