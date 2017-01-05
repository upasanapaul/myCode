public class StringArrayTest {
    public static list<string> generateStringArray(integer n){
        list<string> lis=new list<string>();
        for(integer i=0;i<n;i++)
        {
            lis.add('Test '+i);
            system.debug(lis[i]);
        }
        return lis;
        
    }

}