<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="SummerContacts.Pages.ContactPages.Create" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Summer Contacts</title>
    <%--<link href="../../Styles/reset.css" rel="stylesheet" />--%>
    <link href="../../Styles/main.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="flashMessages">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <asp:PlaceHolder ID="SuccessPlaceHolder" runat="server" Visible="false">
                <asp:PlaceHolder ID="InsertPlaceHolder" runat="server" Visible="false">
                    <div>
                        Kontakten lades till.
                    </div>
                </asp:PlaceHolder>
                <asp:Button ID="HideSuccessMessagesButton" runat="server" 
                            Text="Dölj" OnClick="HideSuccessMessagesButton_Click" 
                            CausesValidation="false"/>
            </asp:PlaceHolder>
        </div>
    <div id="content">
        <h1>
            Summer Contacts
        </h1>
        <asp:FormView ID="FormView1" runat="server"
            ItemType="SummerContacts.Model.BLL.Contact"
            InsertMethod="ContactFormView_InsertItem"
            DefaultMode="Insert"
            RenderOuterTable="false">
                <InsertItemTemplate>
   
                    <div id="formViewTemplate">
                        <div>
                            <asp:Label ID="FirstNameLabel" runat="server" Text="Förnamn" AssociatedControlID="InsertFirstNameTextBox" />
                            <asp:TextBox ID="InsertFirstNameTextBox" runat="server"
                                MaxLength="30"
                                Text='<%#: BindItem.FirstName %>' />
                        </div>
                        <div>
                            <asp:Label ID="LastNameLabel" runat="server" Text="Efternamn" AssociatedControlID="InsertLastNameTextBox" />
                            <asp:TextBox ID="InsertLastNameTextBox" runat="server"
                                MaxLength="30"
                                Text='<%#: BindItem.LastName %>' />
                        </div>
                        <div>
                            <asp:Label ID="EmailAddressLabel" runat="server" Text="E-post" AssociatedControlID="InsertEmailAddressTextBox" />
                            <asp:TextBox ID="InsertEmailAddressTextBox" runat="server"
                                MaxLength="40"
                                Text='<%#: BindItem.EmailAddress %>' />
                        </div>
                        <div>
                            <asp:RegularExpressionValidator ID="EmailAddressRegularExpressionValidator" runat="server"
                                ErrorMessage="Fel format på epost-addressen." Display="None"
                                ControlToValidate="InsertEmailAddressTextBox"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            <asp:RegularExpressionValidator ID="FirstNameRegularExpressionValidator" runat="server"
                                ErrorMessage="Fel format på förnamnet."
                                ControlToValidate="InsertFirstNameTextBox" Display="None"
                                ValidationExpression="^[a-zA-Z]'?([a-zA-Z]|\.| |-)+$" />
                            <asp:RegularExpressionValidator ID="LastNameRegularExpressionValidator" runat="server"
                                ErrorMessage="Fel format på förnamnet."
                                ControlToValidate="InsertFirstNameTextBox" Display="None"
                                ValidationExpression="^[a-zA-Z]'?([a-zA-Z]|\.| |-)+$" />
                            <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server"
                                ErrorMessage="Fyll i ett förnamn."
                                ControlToValidate="InsertFirstNameTextBox" Display="None" />
                            <asp:RequiredFieldValidator ID="LastNameRequiredFieldValidator" runat="server"
                                ErrorMessage="Fyll i ett efternamn."
                                ControlToValidate="InsertLastNameTextBox" Display="None" />
                            <asp:RequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
                                ErrorMessage="Fyll i en e-postaddress."
                                ControlToValidate="InsertEmailAddressTextbox" Display="None" />
                        </div>
                    <div id="editButtons">
                        <asp:LinkButton ID="AddButton" runat="server" CommandName="Insert" Text="Lägg till" />
                        <asp:LinkButton ID="ResetButton" runat="server" CommandName="Cancel" Text="Rensa" CausesValidation="false" />
                    </div>
                    </div>
                    </div>
                </InsertItemTemplate>
        </asp:FormView>
    <div id="links">
        <asp:HyperLink ID="ToListingHyperLink" NavigateUrl="<%$ RouteUrl:routename=Default %>" runat="server" Text="Tillbaka"/>
    </div>
    </div>

    </form>
</body>
</html>
