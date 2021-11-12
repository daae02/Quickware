/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;
import com.fasterxml.jackson.annotation.JsonProperty;
/**
 *
 * @author DiegoAlvarez
 */
public class Repartidor {
    public final  int id;
    public final  String name;
    public final  String email;
    public final String vehicleId;
    public final String phoneNumber;
    public final String password;
    
    public Repartidor(
            @JsonProperty("DealerId") Integer dealerId,
            @JsonProperty("Name") String name,
            @JsonProperty("Email") String email,
            @JsonProperty("PhoneNumber") String phoneNumber,
            @JsonProperty("VehicleId") String vehicleId
    ){
        this.id = dealerId;
        this.name = name;
        this.email = email;
        this.vehicleId = vehicleId;
        this.phoneNumber = phoneNumber;
        this.password = "";
    }

    public Repartidor(String name, String email, String vehicleId, String phoneNumber, String password) {
        this.id = 0;
        this.name = name;
        this.email = email;
        this.vehicleId = vehicleId;
        this.phoneNumber = phoneNumber;
        this.password = password;
    }
}
