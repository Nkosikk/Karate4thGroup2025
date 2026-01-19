package NdosiApITests;

import com.intuit.karate.Results;
import com.intuit.karate.junit5.Karate;

public class NdosiApiTests {

    @Karate.Test
    Karate testNdosiAPI() {
        return Karate.run("classpath:Features/ndosiApi.feature");
    }

    @Karate.Test
    Results testNdosiAPIParallel() {
        return Karate.run("classpath:Features/ndosiApi.feature").parallel(5);
    }
}
