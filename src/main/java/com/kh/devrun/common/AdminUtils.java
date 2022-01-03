package com.kh.devrun.common;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.List;

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
					+ "<td>"+m.getShippingReq()+"</td>\r\n"
					+ "</tr>");
		}
		return sb.toString();
	}

}
