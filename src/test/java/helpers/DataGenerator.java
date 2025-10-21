package helpers;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

public class DataGenerator {

    private static Faker faker = new Faker();

    public static String getRandomEmail() {
        return faker.name().firstName().toLowerCase() + faker.number().numberBetween(0, 100) + "@email.com";
    }

    public static String getRandomUsername() {
        return faker.name().username();
    }

    public static JSONObject getRandomArticle() {
        JSONObject article = new JSONObject();
        article.put("title", faker.gameOfThrones().character());
        article.put("description", faker.gameOfThrones().city());
        article.put("body", faker.gameOfThrones().dragon());

        return article;
    }
    
}
