package api; 

// Import các thư viện cần thiết
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;

public class VerifyRecaptcha {
    // Khai báo khóa bí mật do Google cung cấp cho reCAPTCHA v2
    private static final String SECRET_KEY = "6Ldf8E4rAAAAAH0DHdsWJs0NdSYoogSdZo6neOy_";
    // URL API xác minh reCAPTCHA
    private static final String VERIFY_URL = "https://www.google.com/recaptcha/api/siteverify";

    // Hàm xác minh reCAPTCHA, nhận vào chuỗi phản hồi từ client
    public static boolean verify(String gRecaptchaResponse) throws IOException {
        // Nếu phản hồi null hoặc rỗng thì trả về false
        if (gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) {
            return false;
        }

        // Tạo URL kết nối đến API xác minh
        URL url = new URL(VERIFY_URL);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

        // Cấu hình phương thức POST và cho phép ghi dữ liệu
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);

        // Xây dựng tham số gửi đi gồm khóa bí mật và phản hồi từ client
        String params = "secret=" + SECRET_KEY + "&response=" + gRecaptchaResponse;
        OutputStream os = conn.getOutputStream();
        os.write(params.getBytes(StandardCharsets.UTF_8)); // Gửi dữ liệu đi dưới dạng UTF-8
        os.flush();
        os.close();

        // Đọc phản hồi từ máy chủ Google
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder response = new StringBuilder();

        // Ghép từng dòng phản hồi lại thành một chuỗi duy nhất
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();

        // Phân tích chuỗi phản hồi JSON để lấy trường "success"
        JsonObject json = JsonParser.parseString(response.toString()).getAsJsonObject();
        return json.get("success").getAsBoolean(); // Trả về true nếu xác minh thành công
    }
}