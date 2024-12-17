reportextension 50100 "DOT Customer Payment Receipt" extends "Customer - Payment Receipt"
{
    dataset
    {
        add("Cust. Ledger Entry")
        {
            column(DonorAuthorised; CompanyInfo."Donor Authorised") { }
            column(CompanyRegNo; CompanyInfo."Registration No.") { }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        layout("Temasek - Customer Payment Receipt")
        {
            Type = RDLC;
            LayoutFile = './reportlayout ext/ReportExt50100_CustPaymentReceipt.rdlc';
            ;
        }
    }
}