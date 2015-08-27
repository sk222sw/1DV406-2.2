using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SummerContacts.Model.BLL
{
    public class Contact : BusinessObjectBase
    {
        public int ContactId { get; set; }
        [Required(ErrorMessage="Ett förnamn måste anges.")]
        [StringLength(30, ErrorMessage="Förnamnet kan inte vara längre än 30 tecken.")]
        public string FirstName { get; set; }
        [Required(ErrorMessage="Ett efternamn måste anges.")]
        [StringLength(30, ErrorMessage = "Efternamnet kan inte vara längre än 30 tecken.")]
        public string LastName { get; set; }    
        [Required(ErrorMessage="E-post måste anges.")]
        [StringLength(40, ErrorMessage = "E-posten kan inte vara längre än 40 tecken.")]
        [EmailAddress(ErrorMessage="E-posten är inte korrekt angiven.")]
        public string EmailAddress { get; set; }

    }
}