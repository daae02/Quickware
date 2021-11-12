package com.example.quickware


import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.*
import org.json.JSONArray
import org.json.JSONObject


class MainActivity : AppCompatActivity() {
    var layout: LinearLayout? = null
    var id : String? = null
    var mapa : HashMap<Button,Int> = HashMap<Button,Int>();
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        layout = findViewById(R.id.container);
        requestName()


    }
    private  fun requestName(){
        val nombre : TextView = findViewById<TextView>(R.id.dealerName)
        val queue = Volley.newRequestQueue(this)
        val url = "http://192.168.8.104:3000/randomDealer"
        val stringRequest = StringRequest(Request.Method.GET, url,
            Response.Listener<String> { response ->
                // Display the first 500 characters of the response string.
                val json = JSONArray(response)
                nombre.text = json.getJSONObject(0).getString("Name")
                id = json.getJSONObject(0).getString("DealerId")
                Log.d("MESA",json.getJSONObject(0).getString("DealerId"))
                requestOrders()
            },
            Response.ErrorListener { Log.d("ERROR","Error")})

        // Add the request to the RequestQueue.
        queue.add(stringRequest)
    }
    private  fun requestOrders(){
        val queue = Volley.newRequestQueue(this)
        val url = "http://192.168.8.104:3000/orders"
        val params= HashMap<String,String>()
        params["id"] = id!!
        val jsonObject = JSONObject(params as Map<*, *>)
        val stringRequest = JsonObjectRequest(Request.Method.POST, url, jsonObject,
                Response.Listener{ response ->
                    // Display the first 500 characters of the response string.
                    val json : JSONArray = response.getJSONArray("data")
                    for (i in 0 until json.length()){
                        var jsonObj : JSONObject = json[i] as JSONObject
                        var name: String = jsonObj.get("EnterpriseName") as String
                        var oID : Int = jsonObj.get("OrderId") as Int
                        var address : String = jsonObj.get("Address") as String
                        var Status : Int = jsonObj.get("StatusId") as Int
                        var contact : String = jsonObj.get("Name") as String
                        contact += " - Tel: "+jsonObj.get("PhoneNumber")
                        addCard(name,address,contact, oID, Status)
                    }

                },
                Response.ErrorListener { Log.d("ERROR","Error")})

        // Add the request to the RequestQueue.
        queue.add(stringRequest)
    }
    private  fun updateOrder(orderId: Int?){
        val queue = Volley.newRequestQueue(this)
        val url = "http://192.168.8.104:3000/updateOrder"
        val params= HashMap<String,String>()
        params["id"] = orderId.toString()!!
        val jsonObject = JSONObject(params as Map<*, *>)
        val stringRequest = JsonObjectRequest(Request.Method.POST, url, jsonObject,
                Response.Listener{ response ->
                    // Display the first 500 characters of the response string.
                    val json : JSONObject? = response
                    Log.d("ERROR",json.toString())
                },
                Response.ErrorListener { Log.d("ERROR","Error")})

        // Add the request to the RequestQueue.
        queue.add(stringRequest)
    }
    @SuppressLint("ResourceAsColor")
    private  fun addCard(name : String, address : String, contact : String, oId : Int, status : Int){
        var view :View = layoutInflater.inflate(R.layout.card, null);
        val nameView: TextView = view.findViewById(R.id.name)
        val addressView: TextView = view.findViewById(R.id.address)
        val contactView: TextView = view.findViewById(R.id.contact)
        val orderNumber: TextView = view.findViewById(R.id.orderNumber)
        nameView.text = name
        addressView.text = address
        contactView.text = contact
        orderNumber.text = "Orden #"+oId
        val report: Button = view.findViewById(R.id.report)
        mapa.put(report,oId)
        if (status == 2){
            report.text = "Despachar"
        }
        else{
            report.text = "Entregar"
        }
        report.setOnClickListener{
            val builder = AlertDialog.Builder(this@MainActivity)
            builder.setMessage("¿Seguro de que quiere hacer este cambio?")
                    .setCancelable(false)
                    .setPositiveButton("Sí") { dialog, id ->
                        if(report.text == "Despachar"){report.text = "Entregar"}
                        else{
                            report.text = "Listo"
                            report.setBackgroundColor(R.color.teal_700)
                            report.isEnabled = false
                        }
                        updateOrder(mapa.get(report))
                    }
                    .setNegativeButton("No") { dialog, id ->
                        dialog.dismiss()
                    }
            val alert = builder.create()
            alert.show()
        }
        this.layout!!.addView(view);
    }
}