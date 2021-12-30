package com.kh.devrun;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.devrun.common.DevrunUtils;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private IamportClient api;
	
	@Autowired
	private ServletContext application;
	
	
	
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
		
		log.debug("{}", "iamport 검증 컨트롤러");
		return api.paymentByImpUid(imp_uid); 
	}
	
	@PostMapping(value="/uploadSummernoteImageFile")
	@ResponseBody
	public Map<String, Object> uploadSummernoteImageFile(@RequestParam("file") MultipartFile upFile) {
		log.debug("file = {}", upFile);
		Map<String, Object> map = new HashMap<>();
		
		String saveDirectory = application.getRealPath("/resources/upload/promotion");
		String originalFilename = upFile.getOriginalFilename();
		String renamedFilename = DevrunUtils.getRenamedFilename(originalFilename);
		
		File dest = new File(saveDirectory, renamedFilename);
		
		try {
			InputStream fileStream = upFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, dest);
			map.put("url", saveDirectory);
			map.put("filename", renamedFilename);
			map.put("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(dest);
			map.put("responseCode", "error");
			e.printStackTrace();
		}
		
		return map;
		
	}
	
	@PostMapping(value="/deleteSummernoteImageFile")
	@ResponseBody
	public void deleteSummernoteImageFile(@RequestParam("imgs") String imgs) {
		log.debug("imgs = {}", imgs);
		String saveDirectory = application.getRealPath("/resources/upload/promotion");
		//csv형식으로 받은 이미지 업로드 파일 이름들 분리해서 String배열에 담기
		String[] filenames = imgs.split("/");
		
		//특정 이름을 가진 파일이 디렉토리에 있을 경우 파일 삭제
		for(String filename : filenames) {
			File file = new File(saveDirectory + "/" + filename);
			
			if(file.exists()) file.delete();
		}
	}
}
