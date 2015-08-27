using SummerContacts.Model.BLL;
using SummerContacts.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SummerContacts.Model
{
    // Servicelagret
    public class Service
    {
        private ContactDAL _contactDAL;

        private ContactDAL ContactDAL
        {
            //lazy initialization
            get { return _contactDAL ?? (_contactDAL = new ContactDAL()); }
        }

        public IEnumerable<Contact> GetContacts()
        {
            return ContactDAL.GetContacts();
        }

        public IEnumerable<Contact> GetPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            totalRowCount = 0;

            foreach (var item in GetContacts())
            {
                totalRowCount += 1;
            }
                
            return GetContacts().Skip(startRowIndex).Take(maximumRows);

        }

        public Contact GetContact(int contactId)
        {
            return ContactDAL.GetContactById(contactId);
        }

        public void DeleteContact(int contactId)
        {
            ContactDAL.DeleteContact(contactId);
        }

        public void SaveContact(Contact contact)
        {
            ICollection<ValidationResult> validationResults;
            if (!contact.Validate(out validationResults))
            {
                throw new AggregateException("Objektet klarade inte valideringen.",
                    validationResults.Select(vr => new ValidationException(vr.ErrorMessage)).ToList().AsReadOnly());
            }
            
            if (contact.ContactId == 0)
            {
                ContactDAL.InsertContact(contact);
            }
            else
            {
                ContactDAL.UpdateContact(contact);
            }
        }
    }
}