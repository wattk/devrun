package com.kh.devrun;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private IamportClient api;
	
	
	
	public HomeController() {
		super();
		//REST API 키, REST API secret 
		this.api = new IamportClient("8343794553669375", "3ecaf2db93a1bded8267d09318b5d6ba441c1c412e19686b81ec859a6ffafc90abe92a15af22b138");
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.debug("HomeController ---- forward ----> index.jsp");

		// welcompage를 직접가지 않고, handler를 거쳐가는 설정
		return "forward:/index.jsp";
	}
	
	@RequestMapping("/error/accessDenied.do")
	public void errorPage() {}
	
	@RequestMapping(value = "/common/search.do", method = RequestMethod.GET)
	public void search() {}
	
	@RequestMapping(value = "/about.do", method = RequestMethod.GET)
	public String about() {
		return "/common/about";
	}
	
	@ResponseBody
	@RequestMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session, @PathVariable(value="imp_uid")String imp_uid) throws IamportResponseException, IOException{
		return api.paymentByImpUid(imp_uid); 
	}
}
