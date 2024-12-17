pageextension 50131 "Cash Receipt Journal Extension" extends "Cash Receipt Journal"
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

                GenJnlBatch: Record "Gen. Journal Batch";
                GenJnlLine: Record "Gen. Journal Line";
                DonorInfo: Record Employee;
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
                                        Rec."Account No." := AllocationAcc."No.";
                                end;
                        end;
                    end;
                    //FDD 4.2 End

                    GenJnlBatch.Reset();
                    GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");
                    if GenJnlBatch.FindSet() then begin

                        DonorInfo.Reset();
                        DonorInfo.SetRange("No.", GenJnlBatch."DOT Authorized Id");
                        if DonorInfo.FindFirst() then begin
                            Rec.AuthorisedPersonIDNo := DonorInfo."No.";
                            Rec.AuthorisedPersonName := DonorInfo."First Name";
                            Rec.Telephone := DonorInfo."Phone No.";
                            Rec.AuthorisedPersonEmail := DonorInfo."E-Mail";

                        end else begin
                            Rec.AuthorisedPersonIDNo := GenJnlBatch."DOT Authorized Id";
                            Rec.AuthorisedPersonName := '';
                            Rec.Telephone := '';
                            Rec.AuthorisedPersonEmail := '';
                        end;
                    end;
                end;
            end;
        }
        addafter("Account No.")
        {
            field(AuthorisedPersonIDNo; Rec.AuthorisedPersonIDNo)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonName; Rec.AuthorisedPersonName)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(Telephone; Rec.Telephone)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field(AuthorisedPersonEmail; Rec.AuthorisedPersonEmail)
            {
                Editable = false;
                ApplicationArea = Basic, Suite;
            }
        }

        addafter("Amount (LCY)")
        {
            field(IRASAmt; Rec.IRASAmt)
            {
                //Round(-Rec.Amount, 1, '>')
                //Editable = false;
                ApplicationArea = Basic, Suite;
            }
            field("Donor Payment Method Code"; Rec."Donor Payment Method Code")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Tax E"; Rec."Tax E")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Donor Email"; Rec."Donor Email")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Email Status"; Rec."Email Status")
            {
                ApplicationArea = Basic, Suite;
            }
        }

        modify(Amount)
        {
            trigger OnAfterValidate()
            begin
                //setIRASAmt();
            end;
        }
        modify("Amount (LCY)")
        {
            trigger OnAfterValidate()
            begin
                //setIRASAmt();
            end;

        }
    }
    //Modify a field that initialize other field
    // trigger OnAfterGetRecord()
    // var
    //     GenJnlLine: Record "Gen. Journal Line";
    // begin
    //     //"Journal Template Name", "Journal Batch Name", "Line No."
    //     GenJnlLine.Reset();
    //     GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
    //     GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
    //     GenJnlLine.SetRange("Line No.");
    //     if GenJnlLine.FindSet() then begin
    //         repeat
    //             GenJnlLine.IRASAmt := Abs(Round(GenJnlLine.Amount, 1, '>'));
    //             GenJnlLine.Modify();
    //         until GenJnlLine.Next() = 0;
    //     end;
    // end;

    trigger OnAfterGetRecord()
    var
    begin
        getDonorInfo();
        //setIRASAmt();
    end;



    local procedure getDonorInfo()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        DonorInfo: Record Employee;
    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");

        //"Journal Template Name", "Journal Batch Name", "Line No."
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Line No.");
        if GenJnlBatch.FindFirst() then begin
            if GenJnlLine.FindSet() then begin
                repeat
                    DonorInfo.Reset();
                    DonorInfo.SetRange("No.", GenJnlBatch."DOT Authorized Id");
                    if DonorInfo.FindFirst() then begin
                        GenJnlLine.AuthorisedPersonIDNo := DonorInfo."No.";
                        GenJnlLine.AuthorisedPersonName := DonorInfo."First Name";
                        GenJnlLine.Telephone := DonorInfo."Phone No.";
                        GenJnlLine.AuthorisedPersonEmail := DonorInfo."E-Mail";
                    end else begin
                        GenJnlLine.AuthorisedPersonIDNo := GenJnlBatch."DOT Authorized Id";
                        GenJnlLine.AuthorisedPersonName := '';
                        GenJnlLine.Telephone := '';
                        GenJnlLine.AuthorisedPersonEmail := '';
                    end;
                    GenJnlLine.Modify();
                until GenJnlLine.Next() = 0;
            end;
        end;

    end;

    // local procedure getDonorInfo(ID: Code[20]): Record Employee
    // var
    //     DonorInfo: Record Employee;
    // begin
    //     DonorInfo.Reset();
    //     DonorInfo.SetRange("No.", ID);
    //     if DonorInfo.FindFirst() then
    //         exit(DonorInfo);
    // end;

    local procedure setIRASAmt()
    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
    begin

        GenJnlBatch.Reset();
        GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");

        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        GenJnlLine.SetRange("Line No.");
        if GenJnlBatch.FindFirst() then begin
            if GenJnlLine.FindSet() then begin
                repeat

                    GenJnlLine.IRASAmt := Round(-GenJnlLine.Amount, 1, '>');

                    GenJnlLine.Modify();
                until GenJnlLine.Next() = 0;
            end;
        end;
    end;

}
