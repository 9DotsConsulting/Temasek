pageextension 50128 "DOT Customer Card" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group(Donor)
            {
                field("ID Type No."; Rec."ID Type No.")
                {
                    Caption = 'ID Type';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."ID Type No." = '' then
                            Error('ID Type is mandatory!');

                        case Rec."ID Type No." of
                            '1':
                                begin
                                    Rec."Indicator No." := 'IND';
                                end;
                            '2':
                                begin
                                    Rec."Indicator No." := 'IND';
                                end;
                            '5':
                                begin
                                    Rec."ID No." := 'NNNNNNNNC';
                                    Rec."Indicator No." := 'NON';
                                end;
                            '6':
                                begin
                                    Rec."ID No." := 'YYYYNNNNNC';
                                    Rec."Indicator No." := 'NON';
                                end;
                            'A':
                                begin
                                    Rec."ID No." := 'ANNNNNNNC';
                                    Rec."Indicator No." := 'NON';
                                end;
                            'I':
                                begin
                                    Rec."ID No." := 'NNNNNNNNNC';
                                    Rec."Indicator No." := 'NON';
                                end;
                            else begin
                                Rec."ID No." := 'TyyPQnnnnC';
                                Rec."Indicator No." := 'NON';
                            end;
                        end;
                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    Caption = 'ID No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CustLedgEntries: Record "Cust. Ledger Entry";
                        IDNo: Text[20];
                    begin
                        // if Rec."ID No." = '' then
                        //     Error('ID No. is mandatory!');

                        if Rec."ID No." <> '' then begin
                            IDNo := Rec."ID No.";

                            case Rec."ID Type No." of
                                '1':
                                    begin
                                        If not IDNo.contains('S') AND not IDNo.contains('T') then
                                            Error('ID No. prefix must be S or T');
                                    end;

                                '2':
                                    begin
                                        If not IDNo.contains('F') AND not IDNo.contains('G') AND not IDNo.contains('M') then
                                            Error('ID No. prefix must be F, G or T');
                                    end;
                            end;
                        end;

                        CustLedgEntries.Reset();
                        CustLedgEntries.SetRange("Customer No.", Rec."No.");
                        if CustLedgEntries.FindSet() then begin
                            repeat
                                CustLedgEntries."ID No." := Rec."ID No.";
                                CustLedgEntries.Modify();
                            until CustLedgEntries.Next = 0;
                        end;
                    end;
                }
                field("Indicator No.";
                Rec."Indicator No.")
                {
                    Caption = 'Individual Indicator';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec."Indicator No." = '' then
                            Error('Individual Indicator is mandatory!');
                    end;
                }
                field("Type No."; Rec."Type No.")
                {
                    Caption = 'Type of Donation';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Type No." = '' then
                            Error('Type of Donation is mandatory!');
                    end;
                }
                field("Naming No."; Rec."Naming No.")
                {
                    Caption = 'Naming Donation';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Naming No." = '' then
                            Error('Naming Donation is mandatory!');
                    end;
                }

                #region Donor Email

                part(DonorEmailList; "DOT Donor Email List Page")
                {
                    ApplicationArea = Suite;
                    SubPageLink = "Donor No." = field("No.");
                }

                #endregion Donor Email
            }
        }

    }

    actions
    {
        addafter("Item References")
        {
            action("Email List")
            {
                Visible = ActionVisible;
                Caption = 'Donor Email List';
                ApplicationArea = Suite;
                Image = Email;
                RunObject = Page "DOT Donor Email List";
                RunPageLink = "Donor No." = field("No.");

            }
        }
        addafter("Item References_Promoted")
        {
            actionref(EmailList_Promoted; "Email List")
            {

            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        Rec."Type No." := 'O';
        Rec."Naming No." := 'Z';
    end;

    trigger OnAfterGetRecord()
    var
        CustNo: Text[20];
    begin
        CustNo := Rec."No.";
        if CustNo.contains('DNO') then
            ActionVisible := true
        else
            ActionVisible := false;
    end;

    var
        ActionVisible: Boolean;
}