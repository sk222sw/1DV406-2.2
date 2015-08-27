using SummerContacts.Model.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace SummerContacts.Model.DAL
{
    public class ContactDAL
    {
        #region fält/egenskaper
        private static string _connectionString;
        static ContactDAL()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["SummerContactsConnectionString"].ConnectionString;
        }
        #endregion
        private static SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }

        #region CRUD
        //Hämtar uppgifter från DB och 
        //returnerar referenser till Contact-objekt i listan contacts
        public IEnumerable<Contact> GetContacts()
        {
            //öppna anslutning till DB
            using (var conn = CreateConnection())
            {

                try
                {
                    var contacts = new List<Contact>(100);

                    //skapa ett objekt för SPROC:en
                    var cmd = new SqlCommand("Person.uspGetContacts", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {

                        //hämta index för DB-kolumnerna
                        var ContactIdIndex = reader.GetOrdinal("ContactId");
                        var FirstNameIndex = reader.GetOrdinal("FirstName");
                        var LastNameIndex = reader.GetOrdinal("LastName");
                        var EmailAddressIndex = reader.GetOrdinal("EmailAddress");

                        //lägg till nya Contact-objektsreferenser i listan 
                        //så länge .Read hittar några, dvs är true
                        while (reader.Read())
                        {
                            contacts.Add(new Contact
                                {
                                    ContactId = reader.GetInt32(ContactIdIndex),
                                    FirstName = reader.GetString(FirstNameIndex),
                                    LastName = reader.GetString(LastNameIndex),
                                    EmailAddress = reader.GetString(EmailAddressIndex)
                                });
                        }
                    }

                    //ta bort tomma listplatser
                    contacts.TrimExcess();

                    return contacts;
                }
                catch (Exception)
                {
                    throw new ApplicationException("Ett fel inträffade när kontakterna skulle hämtas från databasen.");
                }
            }
        }

        //hämta en kontakt
        //returnera Contact-objekt
        public Contact GetContactById(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    //sqlcommand-objekt för att köra SPROC
                    SqlCommand cmd = new SqlCommand("Person.uspGetContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    //lägg till Id till SPROCEN
                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = contactId;

                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        //hämta index för DB-kolumnerna
                        var ContactIdIndex = reader.GetOrdinal("ContactId");
                        var FirstNameIndex = reader.GetOrdinal("FirstName");
                        var LastNameIndex = reader.GetOrdinal("LastName");
                        var EmailAddressIndex = reader.GetOrdinal("EmailAddress");

                        //om kunden finns...
                        if (reader.Read())
                        {
                            return new Contact
                            {
                                ContactId = reader.GetInt32(ContactIdIndex),
                                FirstName = reader.GetString(FirstNameIndex),
                                LastName = reader.GetString(LastNameIndex),
                                EmailAddress = reader.GetString(EmailAddressIndex)
                            };
                        }
                    }
                    //... annars returnr null
                    return null;
                }
                catch (Exception)
                {
                    throw new ApplicationException("Ett fel inträffade när en kontakt skulle hämtas från databasen.");
                }
            }
        }

        public void DeleteContact(int contactId)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    //sätt variabeln cmd till ett SqlCommand-objekt som utför en SPROC
                    var cmd = new SqlCommand("Person.uspRemoveContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    //lägg till in-variabeln som Id till SPROC:en
                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = contactId;

                    conn.Open();

                    //Delete skickar ingen fråga = NonQuery
                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    throw new ApplicationException("Ett fel inträffade när konakten skulle raderas.");
                }
            }
        }

        public void UpdateContact(Contact contact)
        {
            using (var conn = CreateConnection())
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Person.uspUpdateContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = contact.ContactId;
                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar, 30).Value = contact.FirstName;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar, 30).Value = contact.LastName;
                    cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar, 30).Value = contact.EmailAddress;

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    throw new ApplicationException("Ett fel inträffade när kontakten skulle uppdateras.");
                }

            }
        }

        public void InsertContact(Contact contact)
        {
            using (var conn = CreateConnection()) 
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("Person.uspAddContact", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@FirstName", SqlDbType.VarChar, 30).Value = contact.FirstName;
                    cmd.Parameters.Add("@LastName", SqlDbType.VarChar, 30).Value = contact.LastName;
                    cmd.Parameters.Add("@EmailAddress", SqlDbType.VarChar, 40).Value = contact.EmailAddress;

                    cmd.Parameters.Add("@ContactId", SqlDbType.Int, 4).Value = ParameterDirection.Output;

                    conn.Open();

                    cmd.ExecuteNonQuery();

                    contact.ContactId = (int)cmd.Parameters["@ContactId"].Value;
                }
                catch (Exception)
                {
                    throw new ApplicationException("Ett fel inträffade när kontakten skulle skapas.");
                }

            }
        }

        #endregion
    }
}