package NdosiApITests;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;

public class NdosiApiTests {

    @Karate.Test
    Karate testNdosiAPI() {
        return Karate.run("classpath:Features/NdosiAPI");
    }

   // @Karate.Test
    //Results testNdosiAPIParallel() {
     //   return Karate.run("classpath:Features/NdosiAPI/ndosiApi.feature").parallel(5);}
}
