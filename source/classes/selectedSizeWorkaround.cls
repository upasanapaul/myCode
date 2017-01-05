public class selectedSizeWorkaround {

    ApexPages.StandardSetController setCon;

    public selectedSizeWorkaround(ApexPages.StandardSetController controller) {
        setCon = controller;
    }

    public integer getMySelectedSize() {
        return setCon.getSelected().size();
    }
    public integer getMyRecordsSize() {
        return setCon.getRecords().size();
    }
    public PageReference DeleteQuoteLineItem() {
    string passedParam1 = Apexpages.currentPage().getParameters().get('myParam');
        system.debug('Delete Quote Line Item with '+passedParam1);
        if(getMySelectedSize()==0)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'None selected....'));
        }
        return null;
    }
}