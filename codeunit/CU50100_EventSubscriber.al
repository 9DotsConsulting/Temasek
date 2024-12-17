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

    end;

}
