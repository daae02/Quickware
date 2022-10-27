/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Requests;

import Models.Repartidor;
import Models.Response;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


/**
 *
 * @author DiegoAlvarez
 */
public class Requester {
    public Requester(){};
    public Repartidor[] requestRepartidores() throws MalformedURLException, ProtocolException, IOException, JSONException{
        ObjectMapper mapper = new ObjectMapper();
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpGet request = new HttpGet("http://25.7.170.231:3000/repartidores");
            HttpResponse response = client.execute(request);  
            client.close();
            return mapper.readValue(response.getEntity().getContent(), Repartidor[].class);        
        }
    }
    public Response registerRepartidor(Repartidor rep) throws ClientProtocolException, IOException, JSONException {
            ObjectMapper mapper = new ObjectMapper();
            String jsonInString = mapper.writeValueAsString(rep);
            CloseableHttpClient client = HttpClients.createDefault();
            HttpPost httpPost = new HttpPost("http://localhost:3000/addRepartidor");
            httpPost.getRequestLine();
            httpPost.setHeader("Content-type", "application/json");
            httpPost.setEntity(new StringEntity(jsonInString));
            HttpResponse response = client.execute(httpPost);  
            client.close();
            return mapper.readValue(response.getEntity().getContent(), Response.class);
    }
}
