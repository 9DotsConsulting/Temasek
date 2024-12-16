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
        }
    }
}
