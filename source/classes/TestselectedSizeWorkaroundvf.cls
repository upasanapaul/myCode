@istest
public class TestselectedSizeWorkaroundvf {
@istest static void TestselectedSizeWorkaroundvfMethod()
{//test with records
      List<account> accountList = new List<Account>();
    for(Integer i = 0; i < 20; i++)
    {
      Account a = new Account(name = 'A'+i);
        accountList.add(a);
    } 
                ApexPages.StandardSetController ssc = new ApexPages.StandardSetController(accountList);
    
    PageReference pageRef = Page.CertifyFlag;
    Test.setCurrentPage(pageRef);
                selectedSizeWorkaround controller = new selectedSizeWorkaround(ssc);
    integer selectSize;
    selectSize = controller.getMySelectedSize();
     integer selectSize1;
    selectSize1 = controller.getMyRecordsSize();
    System.assertEquals(controller.getMySelectedSize(), selectSize);
    controller.DeleteQuoteLineItem();
  

    List<account> accountList2 = new List<Account>();
                ssc = new ApexPages.StandardSetController(accountList2);
                controller = new selectedSizeWorkaround(ssc);
    selectSize = controller.getMySelectedSize();
    controller.DeleteQuoteLineItem();
     System.assertEquals(controller.getMySelectedSize(), selectSize);


}
}