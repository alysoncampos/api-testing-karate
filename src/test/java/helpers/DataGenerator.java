package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {

    private static Faker faker = new Faker();

    public static String getRandomEmail() {
        return faker.name().firstName().toLowerCase() + faker.number().numberBetween(0, 100) + "@email.com";
    }

    public static String getRandomUsername() {
        return faker.name().username();
    }
    
}
