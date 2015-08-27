using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SummerContacts.Model.BLL
{
    public abstract class BusinessObjectBase
    {
        public bool Validate(out ICollection<ValidationResult> validationResults)
        {
            var validationContext = new ValidationContext(this);
            validationResults = new List<ValidationResult>();

            //true gör att det funkar på fler fält en bara Required
            return Validator.TryValidateObject(this, validationContext, validationResults, true);

        }
    }
}