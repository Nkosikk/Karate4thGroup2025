package NdosiApITests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class NdosiApiTests {

    @Karate.Test
    Karate testNdosiAPI() {
        return Karate.run("classpath:Features/ndosiApi.feature");
    }

    @Test
    void testNdosiAPIParallel() {
        Results results = Runner.path("classpath:Features/ndosiApi.feature")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
