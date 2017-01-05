@isTest
private class AnimalLocatorTest{
    
    @isTest static void AnimalsCalloutsTest() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        
        String ALresult = AnimalLocator.getAnimalNameById(1);
        
        String expectedValue = 'chicken';
        
        System.assertEquals(ALresult, expectedValue);
        
        
    }
}