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
public class Response {
    public final String message;
    public final int code;
    
    public Response(
     @JsonProperty("code") Integer code,
     @JsonProperty("message") String message)
    {
        this.message = message;
        this.code = code;
    }
}
