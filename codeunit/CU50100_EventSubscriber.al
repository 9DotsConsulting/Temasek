codeunit 50100 EventSubscriber
{

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterSetupNewLine', '', true, true)]
    local procedure ModifyNewLineSetup(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template"; GenJournalBatch: Record "Gen. Journal Batch"; LastGenJournalLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
    var
        // GenJnlBatch: Record "Gen. Journal Batch";
        // GenJnlLine: Record "Gen. Journal Line";
        DonorInfo: Record Employee;

    begin

        DonorInfo.Reset();
        DonorInfo.SetRange("No.", GenJournalBatch."DOT Authorized Id");
        if DonorInfo.FindFirst() then begin
            GenJournalLine.AuthorisedPersonIDNo := DonorInfo."No.";
            GenJournalLine.AuthorisedPersonName := DonorInfo."First Name";
            GenJournalLine.Telephone := DonorInfo."Phone No.";
            GenJournalLine.AuthorisedPersonEmail := DonorInfo."E-Mail";
        end else begin
            GenJournalLine.AuthorisedPersonIDNo := GenJournalBatch."DOT Authorized Id";
            GenJournalLine.AuthorisedPersonName := '';
            GenJournalLine.Telephone := '';
            GenJournalLine.AuthorisedPersonEmail := '';
        end;


        // GenJnlBatch.Reset();
        // GenJnlBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
        // GenJnlBatch.SetRange(Name, Rec."Journal Batch Name");

        // //"Journal Template Name", "Journal Batch Name", "Line No."
        // GenJnlLine.Reset();
        // GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        // GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        // GenJnlLine.SetRange("Line No.");
        // if GenJnlBatch.FindFirst() then begin
        //     if GenJnlLine.FindSet() then begin
        //         repeat
        //             DonorInfo.Reset();
        //             DonorInfo.SetRange("No.", GenJnlBatch."DOT Authorized Id");
        //             if DonorInfo.FindFirst() then begin
        //                 GenJnlLine.AuthorisedPersonIDNo := DonorInfo."No.";
        //                 GenJnlLine.AuthorisedPersonName := DonorInfo."First Name";
        //                 GenJnlLine.Telephone := DonorInfo."Phone No.";
        //                 GenJnlLine.AuthorisedPersonEmail := DonorInfo."E-Mail";
        //             end else begin
        //                 GenJnlLine.AuthorisedPersonIDNo := GenJnlBatch."DOT Authorized Id";
        //                 GenJnlLine.AuthorisedPersonName := '';
        //                 GenJnlLine.Telephone := '';
        //                 GenJnlLine.AuthorisedPersonEmail := '';
        //             end;
        //             GenJnlLine.Modify();
        //         until GenJnlLine.Next() = 0;
        //     end;
        // end;

    end;

}
