<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Listing.aspx.cs" Inherits="SummerContacts.Pages.ContactPages.Listing" %>

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
    <div id="content">
        <h1>
            Summer Contacts
        </h1>
        <div id="flashMessages">
            <asp:PlaceHolder ID="SuccessPlaceHolder" runat="server" Visible="false">
                <asp:PlaceHolder ID="UpdateSuccessPlaceHolder" runat="server" Visible="false">
                    <div id="updateSuccess" class="success">
                        Kontakten uppdaterades.
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="InsertPlaceHolder" runat="server" Visible="false">
                    <div class="success">
                        Kontakten lades till.
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="DeletePlaceHolder" runat="server" Visible="false">
                    <div class="success">
                        Kontakten raderades.
                    </div>
                </asp:PlaceHolder>
                <asp:Button ID="HideSuccessMessagesButton" runat="server" 
                            Text="Dölj" OnClick="HideSuccessMessagesButton_Click" 
                            CausesValidation="false"/>
            </asp:PlaceHolder>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="List" />
        </div>
         <asp:ListView ID="ListView1" runat="server"
            ItemType="SummerContacts.Model.BLL.Contact"
            SelectMethod="ContactListView_GetData"
            DeleteMethod="ContactListView_DeleteItem"
            UpdateMethod="ContactListView_UpdateItem"
            DataKeyNames="ContactId">
            <LayoutTemplate>
                <div id="layoutTemplate">
                    <table>
                        <tr>
                            <th>Förnamn</th>
                            <th>Efternamn</th>
                            <th>E-post</th>
                        </tr>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                        <%--platshållare för nya rader--%>
                    </table>
                    <div id="dataPager">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                            <Fields>
                                <asp:NextPreviousPagerField />
                                <asp:NumericPagerField />
                            </Fields> 
                        </asp:DataPager>
                    </div>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td id="firstName">
                        <asp:Label ID="FirstNameLabel" runat="server" Text='<%#: Item.FirstName %>' />
                    </td>
                    <td id="lastName">
                        <asp:Label ID="LastNameLabel" runat="server" Text='<%#: Item.LastName %>' />
                    </td>
                    <td id="email">
                        <asp:Label ID="EmailAddressLabel" runat="server" Text='<%#: Item.EmailAddress %>' />
                    </td>
                    <td>
                        <asp:LinkButton runat="server" CommandName="Delete" Text="Ta bort" CausesValidation="false" 
                            OnClientClick='<%# String.Format("return confirm(\"Ta bort {0} {1}?\")", Item.FirstName, Item.LastName) %>' />
                        <asp:LinkButton runat="server" CommandName="Edit" Text="Redigera" CausesValidation="false" />
                    </td>
                </tr>
                <div>

                </div>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td>
                        <asp:TextBox ID="EditFirstNameTextBox" runat="server" Text='<%#: BindItem.FirstName %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="EditLastNameTextBox" runat="server" Text='<%#: BindItem.LastName %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="EditEmailAddressTextBox" runat="server" Text='<%#: BindItem.EmailAddress %>' />
                    </td>
                    <td>
                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Spara" CausesValidation="true" />
                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Avbryt" CausesValidation="false" />
                    </td>
                </tr>
                <asp:RegularExpressionValidator ID="EmailAddressRegularExpressionValidator" runat="server" 
                                                    ErrorMessage="Fel format på epost-addressen." Display="None" 
                                                    ControlToValidate="EditEmailAddressTextBox" 
                                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                <asp:RegularExpressionValidator ID="FirstNameRegularExpressionValidator" runat="server" 
                                                    ErrorMessage="Fel format på förnamnet." 
                                                    ControlToValidate="EditFirstNameTextBox" Display="None" 
                                                    ValidationExpression="^[a-zA-Z]'?([a-zA-Z]|\.| |-)+$" />
                <asp:RegularExpressionValidator ID="LastNameRegularExpressionValidator" runat="server" 
                                                    ErrorMessage="Fel format på förnamnet." 
                                                    ControlToValidate="EditLastNameTextBox" Display="None" 
                                                    ValidationExpression="^[a-zA-Z]'?([a-zA-Z]|\.| |-)+$" />
                <asp:RequiredFieldValidator ID="UpdateFirstNameRequiredFieldValidator" runat="server" 
                                            ErrorMessage="Förnamn måste fyllas i." 
                                            ControlToValidate="EditFirstNameTextBox" Display="None" />
                <asp:RequiredFieldValidator ID="UpdateLastNameRequiredFieldValidator" runat="server" 
                                            ErrorMessage="Efternamn måste fyllas i." 
                                            ControlToValidate="EditFirstNameTextBox" Display="None" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                            ErrorMessage="E-post måste fyllas i." 
                                            ControlToValidate="EditFirstNameTextBox" Display="None" />
            </EditItemTemplate>
            <EmptyDataTemplate>
                <p>Det finns inga kontakter på sommaren.</p>
            </EmptyDataTemplate>
        </asp:ListView>    
        <div id="links">
            <asp:HyperLink ID="AddContactHyperLink" NavigateUrl="<%$ RouteUrl:routename=Create %>" runat="server" Text="Lägg till kontakt"/>
        </div>
    </div>
    </form>
</body>
</html>
