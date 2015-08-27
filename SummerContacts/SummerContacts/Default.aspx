 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SummerContacts.Default" ViewStateMode="Disabled"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <title></title>
    <script src="Scripts/main.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" DisplayMode="BulletList" />
            <asp:PlaceHolder ID="SuccessPlaceHolder" runat="server" Visible="false">
                <asp:PlaceHolder ID="UpdateSuccessPlaceHolder" runat="server" Visible="false">
                    <div id="updateSuccess">
                        Kontakten uppdaterades.
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="InsertPlaceHolder" runat="server" Visible="false">
                    <div>
                        Kontakten lades till.
                    </div>
                </asp:PlaceHolder>
                <asp:PlaceHolder ID="DeletePlaceHolder" runat="server" Visible="false">
                    <div>
                        Kontakten raderades.
                    </div>
                </asp:PlaceHolder>
                <asp:Button ID="HideSuccessMessagesButton" runat="server" 
                            Text="Dölj" OnClick="HideSuccessMessagesButton_Click" 
                            CausesValidation="false"/>
            </asp:PlaceHolder>
        </div>
        <asp:ListView ID="ListView1" runat="server"
            ItemType="SummerContacts.Model.BLL.Contact"
            SelectMethod="ContactListView_GetData"
            DeleteMethod="ContactListView_DeleteItem"
            UpdateMethod="ContactListView_UpdateItem"
            InsertMethod="ContactListView_InsertItem"
            DataKeyNames="ContactId"
            InsertItemPosition="FirstItem">
            <LayoutTemplate>
                <table>
                    <tr>
                        <th>Förnamn</th>
                        <th>Efternamn</th>
                        <th>E-post</th>
                    </tr>
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    <%--platshållare för nya rader--%>
                    <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                       <Fields>
                           <asp:NextPreviousPagerField />
                           <asp:NumericPagerField />
                       </Fields> 
                    </asp:DataPager>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="FirstNameLabel" runat="server" Text='<%#: Item.FirstName %>' />
                    </td>
                    <td>
                        <asp:Label ID="LastNameLabel" runat="server" Text='<%#: Item.LastName %>' />
                    </td>
                    <td>
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
                        <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Spara" CausesValidation="false" />
                        <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Avbryt" CausesValidation="false" />
                    </td>
                </tr>
                <asp:RequiredFieldValidator ID="UpdateNameRequiredFieldValidator" runat="server" 
                                            ErrorMessage="Editname måste fyllas i" 
                                            ControlToValidate="EditFirstNameTextBox" Display="None" />
            </EditItemTemplate>
            <EmptyDataTemplate>
                <p>Det finns inga kontakter på sommaren.</p>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <tr>
                    <td>
                        <asp:TextBox ID="InsertFirstNameTextBox" runat="server"
                             MaxLength="30"
                             Text='<%#: BindItem.FirstName %>'/>
                    </td>
                    <td>
                        <asp:TextBox ID="InsertLastNameTextBox" runat="server" 
                            MaxLength="30"
                            Text='<%#: BindItem.LastName %>'/>
                    </td>
                    <td>
                        <asp:TextBox ID="InsertEmailAddressTextBox" runat="server" 
                            MaxLength="40"
                            Text='<%#: BindItem.EmailAddress %>'/>
                    </td>
                    <asp:RequiredFieldValidator ID="FirstNameRequiredFieldValidator" runat="server" 
                                                ErrorMessage="Fyll i ett förnamn." 
                                                ControlToValidate="InsertFirstNameTextBox" Display="None" />
                    <asp:requiredfieldvalidator ID="LastNameRequiredFieldValidator" runat="server" 
                                                ErrorMessage="Fyll i ett efternamn." 
                                                ControlToValidate="InsertLastNameTextBox" Display="None" />
                    <asp:requiredfieldvalidator ID="EmailAddressRequiredFieldValidator" runat="server" 
                                                ErrorMessage="Fyll i en e-postaddress." 
                                                ControlToValidate="InsertEmailAddressTextbox" Display="None" />
                </tr>
                <td>
                    <asp:LinkButton ID="AddButton" runat="server" CommandName="Insert" Text="Lägg till" />
                    <asp:LinkButton ID="ResetButton" runat="server" CommandName="Cancel" Text="Rensas" CausesValidation="false" />
                </td>
            </InsertItemTemplate>
        </asp:ListView>
    </div>
    </form>
</body>
</html>
