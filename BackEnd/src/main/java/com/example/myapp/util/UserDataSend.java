package com.example.myapp.util;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.Map;

public class UserDataSend {
    public static void sendUserData(Map<String, String> userInfo) {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(userInfo);

            HttpPost httpPost = new HttpPost("http://localhost:8501");
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setEntity(new StringEntity(json));

            try (CloseableHttpResponse response = client.execute(httpPost)) {
                System.out.println(response.getStatusLine().getStatusCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}