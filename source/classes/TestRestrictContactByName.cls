@isTest
public class TestRestrictContactByName {
@isTest static void TestLastName()
{
    Test.startTest();
    Contact c0=new Contact(LastName='abcxyz',Email='abcxyz@asb.com',MobilePhone='1231231231');
  
    Database.SaveResult d0=Database.insert(c0,false);
    Contact c1=new Contact(LastName='INVALIDNAME',Email='abcxyz@asb.com',MobilePhone='1231231231');
  
    Database.SaveResult d1=Database.insert(c1,false);
	Test.stopTest();
    System.assert(!d1.isSuccess());
      System.assert(d0.isSuccess());
}
}