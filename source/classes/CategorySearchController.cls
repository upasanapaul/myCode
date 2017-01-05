public class CategorySearchController {

    // the results from the search. do not init the results or a blank rows show up initially on page load
    public List<categoryWrapper> searchResults {get;set;}
    // the categories that were checked/selected.
    public List<categoryWrapper> selectedCategories {
        get {
            if (selectedCategories == null) selectedCategories = new List<categoryWrapper>();
            return selectedCategories;	
        }
        set;
    }      

    // the text in the search box
    public string searchText {
        get {
            if (searchText == null) searchText = 'black'; // prefill the serach box for ease of use
            return searchText;
        }
        set;
    } 

    // constructor
    public CategorySearchController() {}

    // fired when the search button is clicked
    public PageReference search() {

        if (searchResults == null) {
            searchResults = new List<categoryWrapper>(); // init the list if it is null
        } else {
            searchResults.clear(); // clear out the current results if they exist
        }
        // Note: you could have achieved the same results as above by just using:
        // searchResults = new List<categoryWrapper>();

        // dynamic soql for fun
       //> String qry = 'Select c.Name, c.Id From Cat3__c c ';
           String qry = 'Select a.mergeall__c, a.Id From Attendance_Reporting__c a ';
        // may need to modify for governor limits??
        
        //>for(Cat3__c c : Database.query(qry)) 
        for (Attendance_Reporting__c a : Database.query(qry))
        {
            // create a new wrapper by passing it the category in the constructor
            CategoryWrapper cw = new CategoryWrapper(a);
            // add the wrapper to the results
            searchResults.add(cw);
        }
        return null;
    }   

    public PageReference next() {

        // clear out the currently selected categories
        selectedCategories.clear();

        // add the selected categories to a new List
        for (CategoryWrapper cw : searchResults) {
            if (cw.checked)
                //> selectedCategories.add(new CategoryWrapper(cw.cat));
                selectedCategories.add(new CategoryWrapper(cw.attReport));
        }

        // ensure they selected at least one category or show an error message.
        if (selectedCategories.size() > 0) {
           //return Page.Category_Results;
           return null;
        } else {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select at least one Category.'));
            return null;
        }       

    }       

    // fired when the back button is clicked
    public PageReference back() {
       // return Page.Category_Search;
        return null;
    }       

}