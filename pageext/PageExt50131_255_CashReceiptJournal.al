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
                            if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                                Rec."Account No." := Customer."No.";

                                //Assign Donor Emails
                                Rec."Donor Email" := getDonorEmails(Rec."Account No.");

                            end;
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
                    //FDD 4.2 End

                    // GenJnlBatch.Reset();
                    // GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    // GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");
                    // if GenJnlBatch.FindSet() then begin

                    //     DonorInfo.Reset();
                    //     DonorInfo.SetRange("No.", GenJnlBatch."DOT Authorized Id");
                    //     if DonorInfo.FindFirst() then begin
                    //         Rec.AuthorisedPersonIDNo := DonorInfo."No.";
                    //         Rec.AuthorisedPersonName := DonorInfo."First Name";
                    //         Rec.Telephone := DonorInfo."Phone No.";
                    //         Rec.AuthorisedPersonEmail := DonorInfo."E-Mail";

                    //     end else begin
                    //         Rec.AuthorisedPersonIDNo := GenJnlBatch."DOT Authorized Id";
                    //         Rec.AuthorisedPersonName := '';
                    //         Rec.Telephone := '';
                    //         Rec.AuthorisedPersonEmail := '';
                    //     end;
                    // end;
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
                trigger OnLookup(var Text: Text): Boolean
                var
                    RecRef: RecordRef;
                    //RecPage: Page "DOT Donor Email List Page";
                    RecPage: Page "DOT Donor Email List";
                    RecTable: Record "DOT Donor Email List";
                    MarkTable: Record "DOT Donor Email List";
                    MultiSelectCU: Codeunit SelectionFilterManagement;
                    NewText: Text;
                begin
                    Clear(RecPage);
                    Clear(RecTable);
                    Clear(RecTable);
                    RecTable.SetRange("Donor No.", Rec."Account No.");
                    if RecTable.FindSet() then begin
                        RecRef.GetTable(RecTable);
                        RecPage.LookupMode := true;
                        RecPage.SetTableView(RecTable);
                        if RecPage.RunModal() = Action::LookupOK then begin

                            RecPage.SetSelectionFilter(RecTable);
                            repeat

                                if RecTable.Mark() then begin

                                    if NewText <> '' then
                                        NewText += ';';

                                    NewText += RecTable.Email;

                                end;

                            until RecTable.Next() = 0;
                            Text := NewText;

                            exit(true);
                        end else
                            exit(false);
                    end;

                end;

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


    actions
    {
        addafter(Post)
        {
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Email to Donor';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Email;
                Enabled = false;
                Visible = false;

                trigger OnAction()
                var
                    GenJnlBatch: Record "Gen. Journal Batch";
                    GenJnlLine: Record "Gen. Journal Line";
                    CompInfo: Record "Company Information";
                    EmployeeInfo: Record Employee;
                begin
                    //sendDonorEmails();

                    CompInfo.Reset();
                    GenJnlBatch.Reset();
                    GenJnlLine.Reset();
                    EmployeeInfo.Reset();

                    if CompInfo.Get() then begin

                    end;

                    GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");
                    if GenJnlBatch.FindSet() then begin

                        GenJnlLine.SetRange("Journal Template Name", GenJnlBatch."Journal Template Name");
                        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch.Name);
                        GenJnlLine.SetRange("Line No.");
                        if GenJnlLine.FindSet() then begin
                            repeat

                                EmployeeInfo.SetRange("No.", GenJnlLine.AuthorisedPersonIDNo); //check why ID is text[12] in FDD when in BC it's Code[20]
                                if EmployeeInfo.FindFirst() then begin

                                end;

                                sendDonorEmails(GenJnlLine, CompInfo, EmployeeInfo);

                            until GenJnlLine.Next() = 0;
                        end
                    end;

                end;
            }
            action(TestEmail)
            {
                ApplicationArea = All;
                Caption = 'Email to Test Fixed Emails';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Email;
                // Enabled = false;
                // Visible = false;

                trigger OnAction()
                var

                    CompInfo: Record "Company Information";
                begin

                    CompInfo.Reset();

                    if CompInfo.Get() then begin

                    end;

                    sendDummyEmail(CompInfo);

                end;
            }
        }
    }


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

    local procedure getDonorEmails(DonorNo: Code[20]): Text
    var
        DonorEmailList: Record "DOT Donor Email List";
        ReturnTxt: Text;
    begin
        ReturnTxt := '';
        DonorEmailList.Reset();
        DonorEmailList.SetRange("Donor No.", DonorNo);
        DonorEmailList.SetRange(Default, true);
        if DonorEmailList.FindSet() then begin
            repeat

                if (ReturnTxt <> '') then
                    ReturnTxt := ReturnTxt + ';';
                ReturnTxt := ReturnTxt + DonorEmailList.Email;

            until DonorEmailList.Next() = 0;
            exit(ReturnTxt);
        end
        else
            exit('');

    end;

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

    local procedure sendDonorEmails(GenJnlLine: Record "Gen. Journal Line"; CompInfo: Record "Company Information"; EmployeeInfo: Record Employee)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAddress: Text;
        EmailTitle: Text;
    //EmailBody: Text;
    //EmailBody: Label 'Dear Sir/Madam,\';
    begin


        EmailTitle := 'Test Email Title [TF]';
        //EmailBody := 'Test Email Body\New Line\End';


        //EmailMessage.Create(EmailAddress, EmailTitle, EmailBody);
        EmailMessage.Create(EmailAddress, EmailTitle, '');


        EmailMessage.AppendToBody(StrSubstNo('Dear Sir/Madam,\\On behalf of %1, I would like to thank you for your donation of %2 %3 on %4.', CompInfo.Name, GenJnlLine."Currency Code", GenJnlLine.IRASAmt, GenJnlLine."Posting Date")); //Company Name, Currency Code, Amount, Donation Date
        EmailMessage.AppendToBody('We wish to convey our appreciation for your generosity and kindness.\\');
        EmailMessage.AppendToBody('This official receipt for your donation is for your reference and retention.\\');
        EmailMessage.AppendToBody(StrSubstNo('%1', CompInfo."Donor Statement")); //Donor statement from CI

        EmailMessage.AppendToBody('We look forward to your continuous support.\');
        EmailMessage.AppendToBody(StrSubstNo('Please feel free to email us at %1 if you need futher clarification.\\\\', CompInfo."E-Mail")); //Company Email

        EmailMessage.AppendToBody('Yours sincerely,\');
        EmailMessage.AppendToBody(StrSubstNo('%1\', EmployeeInfo.FullName())); //Authorised person name
        EmailMessage.AppendToBody(StrSubstNo('%1\', EmployeeInfo.Title)); //Title
        EmailMessage.AppendToBody(StrSubstNo('%1\', CompInfo.Name)); //Company Name


        Email.Send(EmailMessage);
        //Email.OpenInEditor(EmailMessage);


    end;

    local procedure sendDummyEmail(CompInfo: Record "Company Information")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        EmailAddress: Text;
        EmailTitle: Text;
        EmailAddresses: List of [Text];
    begin

        EmailAddresses.add('afiq.munawir@9dots.com');
        EmailAddresses.add('jiayi.tee@9dots.com');


        EmailTitle := 'Test Email Title [TF]';
        //EmailMessage.Create(EmailAddress, EmailTitle, '', false);
        EmailMessage.Create(EmailAddresses, EmailTitle, '', false);
        EmailMessage.AppendToBody(StrSubstNo('Dear Sir/Madam,\\On behalf of %1, I would like to thank you for your donation of %2 %3 on %4.', CompInfo.Name, 'GenJnlLine."Currency Code"', 'GenJnlLine.IRASAmt', 'GenJnlLine."Posting Date"')); //Company Name, Currency Code, Amount, Donation Date
        EmailMessage.AppendToBody('We wish to convey our appreciation for your generosity and kindness.\\');
        EmailMessage.AppendToBody('This official receipt for your donation is for your reference and retention.\\');
        EmailMessage.AppendToBody(StrSubstNo('%1', CompInfo."Donor Statement")); //Donor statement from CI

        EmailMessage.AppendToBody('We look forward to your continuous support.\');
        EmailMessage.AppendToBody(StrSubstNo('Please feel free to email us at %1 if you need futher clarification.\\\\', CompInfo."E-Mail")); //Company Email

        EmailMessage.AppendToBody('Yours sincerely,\');
        EmailMessage.AppendToBody(StrSubstNo('%1\', 'Authorised person name')); //Authorised person name
        EmailMessage.AppendToBody(StrSubstNo('%1\', 'Title')); //Title
        EmailMessage.AppendToBody(StrSubstNo('%1\', CompInfo.Name)); //Company Name


        if Email.Send(EmailMessage) then
            Message('Emails have been sent.')
        else
            Message('Emails were unabled to be sent.');

    end;


}
