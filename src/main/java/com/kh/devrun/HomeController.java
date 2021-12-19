package com.kh.devrun;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
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
}
