package com.kh.devrun.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.kh.devrun.order.model.vo.Merchant;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AdminUtils {

	
	public static String getMerchantList(List<Merchant> list, String url) {
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
		DecimalFormat fmt = new DecimalFormat("###,###");
		StringBuilder sb = new StringBuilder();
		
		for(Merchant m : list) {
			String orderStatus = ("OR").equals(m.getOrderStatus())? "주문" : "PP".equals(m.getOrderStatus())? "상품준비중": "SS".equals(m.getOrderStatus())?"배송시작":"SP".equals(m.getOrderStatus())?"배송중":"SC".equals(m.getOrderStatus())?"배송완료": "구매확정";
			String csStatus = ("COM").equals(m.getCsStatus())? "정상" : ("REF").equals(m.getCsStatus())? "환불": ("EXC").equals(m.getCsStatus())?"교환":("RET").equals(m.getCsStatus())?"반품":("CAN").equals(m.getCsStatus())?"주문취소":"완료";
			sb.append("<tr>\n"
					+ "<td>"+ m.getMerchantUid() +"</td>\r\n"
					+ "<td>"+ m.getMemberNo() +"</td>\r\n"
					+ "<td>"+ sdf.format(m.getOrderDate()) +"</td>\r\n"
					+ "<td>"+ orderStatus +"</td>\r\n"
					+ "<td>"+ csStatus +"</td>\r\n"
					+ "<td>"+ m.getPointValue() +"</td>\r\n"
					+ "<td>&#8361;"+ fmt.format(m.getProductPrice())+"</td>\r\n"
					+ "<td>&#8361;"+fmt.format(m.getShippingFee())+"</td>\r\n"
					+ "<td>&#8361;"+fmt.format(m.getTotalPrice())+"</td>\r\n"
					+ "</tr>");
		}
		return sb.toString();
	}
	
	public static String getToken(
			HttpServletRequest request
			,HttpServletResponse response
			,JSONObject json
			,String requestUrl) throws Exception{
		// requestURL 아임포트 고유키, 시크릿 키 정보를 포함하는 url 정보 
		String _token = "";
		try{
			String requestString = "";
			URL url = new URL(requestUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true); 				
			connection.setInstanceFollowRedirects(false);  
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			OutputStream os= connection.getOutputStream();
			os.write(json.toString().getBytes());
			connection.connect();
			StringBuilder sb = new StringBuilder(); 
			if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;  
				while ((line = br.readLine()) != null) {  
					sb.append(line + "\n");  
				}
				br.close();
				requestString = sb.toString();
			}
			os.flush();
			connection.disconnect();

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);

			if((Long)jsonObj.get("code")  == 0){
				JSONObject getToken = (JSONObject) jsonObj.get("response");
				log.debug("getToken : {}", getToken.get("access_token") );
				_token = (String)getToken.get("access_token");
			}

		}catch(Exception e){
			e.printStackTrace();
			_token = "";

		}

		return _token;

	}

	public static Map<String, Object> getRefund(
			HttpServletRequest request, 
			HttpServletResponse response, 
			JSONObject json,
			String _token) throws Exception {
		Map<String, Object> map = new HashMap<>();
		String requestString = "";
		String receipt = "";
		try {
			URL url = new URL("https://api.iamport.kr/payments/cancel");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true); 				
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setRequestProperty("Authorization", _token);
			connection.setRequestProperty("Accept", "application/json");
			OutputStream os= connection.getOutputStream();
			os.write(json.toString().getBytes());
			os.flush();
			StringBuilder sb = new StringBuilder(); 
			if(connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
				String line = null;  
				while ((line = br.readLine()) != null) {  
					sb.append(line + "\n");
					log.debug("line = {}",line);
				}
				br.close();
				requestString = sb.toString();
			}
			connection.disconnect();
			log.debug("result : {}", requestString);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(requestString);
			log.debug("jsonObj : {}", jsonObj);
			JSONObject jsonResponse = (JSONObject) jsonObj.get("response");
			String message = (String)jsonObj.get("message");
			map.put("message", message);
			if(message == null) {
				
				log.debug("jsonResponse : {}", jsonResponse);
				List<String> cancelReceiptUrls = (List<String>)jsonResponse.get("cancel_receipt_urls");
				receipt = cancelReceiptUrls.get(0);
				map.put("receipt", receipt);
				map.put("message", "정상 처리되었습니다.");
			}
	
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}
	
		return map;
	}

}
