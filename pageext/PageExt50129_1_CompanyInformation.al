pageextension 50129 "DOT Company Information" extends "Company Information"
{
    layout
    {
        addafter("Contact Person")
        {
            field("Donor Authorised"; Rec."Donor Authorised")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    GenJnlBatch: Record "Gen. Journal Batch";
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    GenJnlBatch.Reset();
                    GenJnlBatch.SetRange("DOT Donor Used", true);
                    if GenJnlBatch.FindSet() then begin
                        repeat

                            GenJnlBatch."DOT Authorized Id" := Rec."Donor Authorised";
                            GenJnlBatch.Modify();

                        until GenJnlBatch.Next() = 0;

                        GenJnlLine.getDonorInfo();
                    end;
                end;
            }
            field("Donor Management"; Rec."Donor Management")
            {
                ApplicationArea = All;
            }
        }

        addbefore(Payments)
        {
            group("Donor Email")
            {
                Caption = 'Donor Email';

                Group("Email Donor (Setup)")
                {
                    Caption = 'Email Donor (Setup)';
                    field("Donor Statement"; Rec."Donor Statement")
                    {
                        MultiLine = true;
                        Caption = 'Donor Statement';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}
