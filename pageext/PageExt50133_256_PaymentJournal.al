pageextension 50133 "Payment Journal Extension" extends "Payment Journal"
{
    layout
    {
        modify("Account No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                //FDD 4.2 Start
                Customer: Record Customer;
                GJB: Record "Gen. Journal Batch";
                GLAcc: Record "G/L Account";
                Vendor: Record Vendor;
                BankAccount: Record "Bank Account";
                FixedAsset: Record "Fixed Asset";
                ICPartner: Record "IC Partner";
                AllocationAcc: Record "Allocation Account";
                Employee: Record Employee;
            //FDD 4.2 End

            begin
                //FDD 4.2 Start
                GJB.Reset();
                GJB.SetFilter(Name, Rec."Journal Batch Name");
                if GJB.FindFirst() then begin
                    if (GJB."DOT Donor Used" = true) AND (Rec."Account Type" = Rec."Account Type"::Customer) then begin
                        Customer.Reset();
                        Customer.SetFilter("No.", '@DNO*');
                        if Customer.FindSet() then begin
                            if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                                Rec."Account No." := Customer."No.";
                        end;
                    end else begin
                        case Rec."Account Type" of
                            rec."Account Type"::Customer:
                                begin
                                    Customer.Reset();
                                    if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                                        Rec."Account No." := Customer."No.";
                                end;
                            rec."Account Type"::Vendor:
                                begin
                                    Vendor.Reset();
                                    if Page.RunModal(Page::"Vendor List", Vendor) = Action::LookupOK then
                                        Rec."Account No." := Vendor."No.";
                                end;
                            Rec."Account Type"::"Bank Account":
                                begin
                                    BankAccount.Reset();
                                    if Page.RunModal(Page::"Bank Account List", BankAccount) = Action::LookupOK then
                                        Rec."Account No." := BankAccount."No.";
                                end;
                            Rec."Account Type"::"Fixed Asset":
                                begin
                                    FixedAsset.Reset();
                                    if Page.RunModal(Page::"Fixed Asset List", FixedAsset) = Action::LookupOK then
                                        Rec."Account No." := FixedAsset."No.";
                                end;
                            Rec."Account Type"::"IC Partner":
                                begin
                                    ICPartner.Reset();
                                    if Page.RunModal(Page::"IC Partner List", ICPartner) = Action::LookupOK then
                                        Rec."Account No." := ICPartner.Code;
                                end;
                            Rec."Account Type"::"G/L Account":
                                begin
                                    GLAcc.Reset();
                                    GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
                                    GLAcc.SetRange(Blocked, false);
                                    if GLAcc.FindSet() then begin
                                        if Page.RunModal(Page::"G/L Account List", GLAcc) = Action::LookupOK then
                                            Rec."Account No." := GLAcc."No.";
                                    end;
                                end;
                            Rec."Account Type"::"Allocation Account":
                                begin
                                    AllocationAcc.Reset();
                                    if Page.RunModal(Page::"Allocation Account List", AllocationAcc) = Action::LookupOK then
                                        Rec."Account No." := AllocationAcc."No.";
                                end;
                            Rec."Account Type"::Employee:
                                begin
                                    Employee.Reset();
                                    if Page.RunModal(Page::"Employee List", Employee) = Action::LookupOK then
                                        Rec."Account No." := Employee."No.";
                                end;
                        end;
                    end;

                end;
            end;
            //FDD 4.2 End
        }
    }
}
