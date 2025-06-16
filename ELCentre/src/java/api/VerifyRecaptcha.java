package api;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class VerifyRecaptcha {
    private static final String SECRET_KEY = "6Ldf8E4rAAAAAH0DHdsWJs0NdSYoogSdZo6neOy_";
    private static final String VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    public static boolean verify(String gRecaptchaResponse) throws IOException {
        if (gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) {
            return false;
        }

        URL url = new URL(VERIFY_URL);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        String params = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;
        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        JsonObject json = JsonParser.parseString(response.toString()).getAsJsonObject();
        return json.get("success").getAsBoolean();
    }
}