package DogsAPITests;

import com.intuit.karate.junit5.Karate;

public class DogsTests {

    @Karate.Test
    Karate testDogsAPI() {
        return Karate.run("classpath:Features/Dogs.feature");
    }


}
