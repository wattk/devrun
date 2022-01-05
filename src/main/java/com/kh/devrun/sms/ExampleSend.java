package com.kh.devrun.sms;

import java.util.HashMap;

import net.nurigo.java_sdk.exceptions.CoolsmsException;
import net.nurigo.java_sdk.api.Message;
import org.json.simple.JSONObject;

/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API PHP
 */

// Message 객체 생성하여 send 메서드 사용하면 됨
public class ExampleSend {
  public static void main(String[] args) {
    String api_key = "NCSTDEQFRIAB8CBC";
    String api_secret = "UCLQIXWFIQCWZBJM4TRKR3J5XHYKUTRP";
    Message coolsms = new Message(api_key, api_secret);

    // 4 params(to, from, type, text) are mandatory. must be filled
    HashMap<String, String> params = new HashMap<String, String>();
    params.put("to", "01074003717");
    params.put("from", "01074003717");
    params.put("type", "LMS");
    params.put("text", "나의 첫번째 메시지 전송 프로그램 테스트");
    params.put("app_version", "test app 1.2"); // application name and version

    try {
      JSONObject obj = (JSONObject) coolsms.send(params);
      System.out.println(obj.toString());
    } catch (CoolsmsException e) {
      System.out.println(e.getMessage());
      System.out.println(e.getCode());
    }
  }
}