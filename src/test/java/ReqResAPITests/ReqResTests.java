package ReqResAPITests;

import com.intuit.karate.junit5.Karate;

public class ReqResTests {

    @Karate.Test
    Karate testReqResAPI() {
        return Karate.run("classpath:Features/reqRes.feature");
    }
}
