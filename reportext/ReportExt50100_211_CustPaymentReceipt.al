reportextension 50100 "DOT Customer Payment Receipt" extends "Customer - Payment Receipt"
{
    dataset
    {
        add("Cust. Ledger Entry")
        {
            column(DonorAuthName; DonorAuthName) { }
            column(DonorAuthTitle; DonorAuthTitle) { }
            column(DonorAmount; DonorAmount) { }
            column(CompanyRegNo; CompanyInfo."Registration No.") { }
        }
        modify("Cust. Ledger Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
                CLE: Record "Cust. Ledger Entry";
                DCLE: Record "Detailed Cust. Ledg. Entry";
                Employee: Record Employee;
            begin
                Clear(DonorAmount);
                DCLE.Reset();
                DCLE.SetRange("Applied Cust. Ledger Entry No.", "Cust. Ledger Entry"."Entry No.");
                DCLE.SetRange("Cust. Ledger Entry No.", "Cust. Ledger Entry"."Entry No.");
                DCLE.SetRange("Document Type", "Gen. Journal Document Type"::Payment);
                if DCLE.FindSet then
                    repeat
                        DonorAmount += DCLE.Amount;
                    until DCLE.Next = 0;
                DonorAmount := -DonorAmount;

                Employee.Reset();
                Employee.SetRange("No.", CompanyInfo."Donor Authorised");
                if Employee.FindFirst() then begin
                    DonorAuthName := Employee."First Name" + Employee."Last Name";
                    DonorAuthTitle := Employee."Job Title";
                end;
            end;
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
    var
        DonorAmount: Decimal;
        DonorAuthName, DonorAuthTitle : Text;
}