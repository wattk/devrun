package com.kh.devrun.mypage.controller;

import java.beans.PropertyEditor;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.devrun.address.model.vo.Address;
import com.kh.devrun.chat.model.service.ChatService;
import com.kh.devrun.common.DevrunUtils;
import com.kh.devrun.community.common.CommunityUtils;
import com.kh.devrun.community.model.service.CommunityService;
import com.kh.devrun.community.model.vo.CommunityEntity;
import com.kh.devrun.member.model.service.MemberService;
import com.kh.devrun.member.model.vo.Member;
import com.kh.devrun.mypage.model.service.MypageService;
import com.kh.devrun.order.model.service.OrderService;
import com.kh.devrun.order.model.vo.MerchantExt;
import com.kh.devrun.order.model.vo.OrderLogExt;
import com.kh.devrun.order.model.vo.Shipment;
import com.kh.devrun.promotion.model.service.PromotionService;
import com.kh.devrun.promotion.model.vo.Promotion;
import com.kh.devrun.report.model.service.ReportService;
import com.kh.devrun.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage")
@Slf4j
public class MypageController {

	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private CommunityService communityService;
	
	@Autowired
	private PromotionService promotionService;
	
	@Autowired
	ServletContext application;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private ChatService chatService;
	
	
	/**
	 * 지원 시작
	 */
	
	/**
	 * 지원 마이페이지 메인 시작
	 */
	@GetMapping("/mypage.do")
	public String mypage(Authentication authentication, Model model) {

		Member loginMember = (Member) authentication.getPrincipal();
		int memberNo = loginMember.getMemberNo();
		
		/* 전체안읽음 메시지 건수 조회 */
		int totalUnreadCount = chatService.selectMessageTotalUnreadCount(memberNo);
		log.debug("totalUnreadCount = {}", totalUnreadCount);
		
		model.addAttribute("totalUnreadCount", totalUnreadCount);
		/* 전체안읽음 메시지 건수 조회 끝 */
		
		/* 최근 이벤트 한개 조회 */
		Promotion promotion = promotionService.selectOneLatestPromotionBanner();
		log.debug("promotion = {}", promotion);
		model.addAttribute("promotion", promotion);
		
		return "mypage/mypage";
	}
	/**
	 * 지원 마이페이지 메인 끝
	 */
	
	/**
	 * 지원 나의 정보 메인 시작
	 */
	@GetMapping("/myinfo.do")
	public String myinfo() {
		
		return "mypage/myinfo";
	}
	/**
	 * 지원 나의 정보 메인 끝
	 */

	/**
	 * 지원 나의 정보 > 활동 배지 시작
	 */
	@GetMapping("/myinfo/activityBadge.do")
	public String activityBagde() {
		
		return "mypage/activityBadge";
	}
	/**
	 * 지원 나의 정보 > 활동 배지 끝
	 */
	
	/**
	 * 지원 나의 정보 > 프로필 수정 시작
	 */
	@GetMapping("/myinfo/profileUpdate.do")
	public String profileUpdate() {
		
		return "mypage/profileUpdate";
		
	}
	
	/**
	 * 이메일 & 닉네임 중복 체크
	 * select * from member where ${checkKeyword} = #{value} and id != #{id}
	 */
	@ResponseBody
	@GetMapping("/myinfo/profileUpdate/checkDuplicate")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param, Authentication authentication){
		log.debug("param = {}", param);
		Map<String, Object> map = new HashMap<>();
		Member principal = (Member) authentication.getPrincipal();
		param.put("id", principal.getId());
		Member member = memberService.selectOneMemberByCheckKeyword(param);
		log.debug("member = {}", member);
		map.put("available", member == null);
		
		return map;
	}
	
	/**
	 * 프로필 수정
	 */
	@PostMapping("/myinfo/profileUpdate.do")
	public String profileUpdate(
			Member member,
			MultipartFile upFile,
			RedirectAttributes redirectAttr,
			Authentication authentication) throws Exception {
			
		String id = member.getId();
		String pro_Photo = member.getProPhoto();
		String password = member.getPassword();
		log.debug("password = {}", password);
		Member principal = (Member) authentication.getPrincipal();
		log.debug("principal = {}", principal);
		/**
		 * 비밀번호 확인
		 * - BCryptPasswordEncoder의 matches()함수로 사용자가 입력한 비밀번호와 DB의 암호화된 비밀번호 값을 비교
		 * - 입력값이 일치하면 프로필 수정 진행
		 * - 입력값이 불일치하면 알림창 띄운 후 return
		 */
		if(passwordEncoder.matches(password, principal.getPassword())) {
			try {
				/**
				 * 첨부파일 등록
				 * - 기존 첨부파일이 있다면 삭제후 새 첨부파일 등록
				 * - 기존 첨부파일이 없다면 새 첨부파일 등록
				 */
				
				//파일 저장 : 절대경로 /resources/upload/profilePhoto
				//application객체(ServletContext)
				String saveDirectory = application.getRealPath("/resources/upload/profilePhoto");
				log.debug("saveDirectory = {}", saveDirectory);
				
				//proPhoto가 null이라면
				if(pro_Photo == null) {
					File proPhoto = new File(saveDirectory + "/" + id + ".png");
					log.debug("proPhoto = {}", proPhoto);
					if(proPhoto.exists()) proPhoto.delete();
				}
				
				if(!upFile.isEmpty() && upFile.getSize() != 0) { //파일이 업로드 되었는지 확인
					log.debug("upFile = {}", upFile);
					log.debug("upFile.name = {}", upFile.getOriginalFilename());
					log.debug("upFile.size = {}", upFile.getSize());
					
					if(member.getProPhoto() != null) { //이미 프로필 사진이 있을 경우
						File proPhoto = new File(saveDirectory + "/" + id + ".png");
						if(proPhoto.exists()) proPhoto.delete();
					}
					String proPhoto = id + ".png";
					member.setProPhoto(proPhoto);
						
					//서버컴퓨터에 저장
					File dest = new File(saveDirectory, proPhoto);
					log.debug("dest = {}", dest);
					upFile.transferTo(dest);
				}
				
				String rawPassword = member.getPassword();
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				member.setPassword(encryptedPassword);
				
				int result = memberService.updateMemberProfile(member);
				String msg = result > 0 ? "프로필 수정이 완료되었습니다." : "프로필 수정에 실패하였습니다.";
				redirectAttr.addFlashAttribute("msg", msg);
				
				//Authentication객체 갱신
				Member updateMember = memberService.selectOneMemberById(id);
				Authentication newAuthentication = 
					new UsernamePasswordAuthenticationToken(
						updateMember,
						authentication.getCredentials(),
						authentication.getAuthorities()
					);
				SecurityContextHolder.getContext().setAuthentication(newAuthentication);
				log.debug("newAuthentication = {}", newAuthentication);
			
			} catch (Exception e) {
				log.error("프로필 수정 오류", e);
				throw e;
			}
			return "redirect:/mypage/myinfo.do";
		}
		else {
			redirectAttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/myinfo/profileUpdate.do";
		}
		
	}
			
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//형식객체, 빈값허용여부("" -> null)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	/**
	 * 회원 탈퇴
	 */
	@PostMapping("/myinfo/memberWithdrawal.do")
	public String memberWithdrawal(@RequestParam String password, Authentication authentication, RedirectAttributes redirectAttr) {
		Member member = (Member) authentication.getPrincipal();
		String id = member.getId();
		
		//비밀번호 확인
		if(passwordEncoder.matches(password, member.getPassword())) {
			try {
				//업로드 된 프로필 사진이 있다면 삭제
				String saveDirectory = application.getRealPath("/resources/upload/profilePhoto");
				if(member.getProPhoto() != null) {
					File proPhoto = new File(saveDirectory + "/" + id + ".png");
					if(proPhoto.exists()) proPhoto.delete();
				}
				int result = memberService.memberWithdrawal(id);
				String msg = result > 0 ? "회원 탈퇴가 완료되었습니다." : "회원 탈퇴에 실패하였습니다.";
				redirectAttr.addFlashAttribute("msg", msg);
				
			} catch (Exception e) {
				log.error("회원 탈퇴 오류", e);
				throw e;
			}
			return "redirect:/member/memberLogout.do";
		}
		else {
			redirectAttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/myinfo/profileUpdate.do";
		}
	}
			
	/**
	 * 지원 나의 정보 > 프로필 수정 끝
	 */
	
	/**
	 * 지원 나의 정보 > 배송지 관리 시작
	 */
	@GetMapping("/myinfo/addressManage.do")
	public String addressManage(@RequestParam(defaultValue = "1") int cPage, Authentication authentication,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			Member member = (Member) authentication.getPrincipal();
			int memberNo = member.getMemberNo();
			
			//1. 전체 주소 목록
			List<Address> addressList = mypageService.selectAllAddressByMemberNo(memberNo, offset, limit);
			model.addAttribute("addressList", addressList);
			log.debug("addressList = {}", addressList);
			
			//2. 전체 주소 수 totalContent
			int totalContent = mypageService.selectAddressTotalCount(memberNo);
			model.addAttribute("totalContent", totalContent);
			
			//3. pagebar
			String url = request.getRequestURI(); // /spring/board/boardList.do
			String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
			
		} catch (Exception e) {
			log.error("주소 목록 조회 오류", e);
			throw e;
		}
		return "mypage/addressManage";
	}
	
	/**
	 * 주소 한개 조회
	 * select * from address where address_no = ${addressNo}
	 */
	@GetMapping("/myinfo/selectOneAddress/{addressNo}")
	public ResponseEntity<Address> selectOneAddress(@PathVariable int addressNo) {
		Address address = mypageService.selectOneAddress(addressNo);
		log.debug("address = {}", address);
		//조회된 결과가 있는 경우
		if(address != null) 
			return new ResponseEntity<>(address, HttpStatus.OK); //200
		//조회된 결과가 없는 경우
		else 
			return new ResponseEntity<>(HttpStatus.NOT_FOUND); //404
	}
	
	/**
	 * 베송지명 중복 체크
	 * select * from address where ${checkKeyword} = #{value} and id != #{id}
	 */
	@ResponseBody
	@GetMapping("/myinfo/addressManage/checkDuplicate")
	public Map<String, Object> checkDuplicate(@RequestParam Map<String, Object> param, Authentication authentication){
		Map<String, Object> map = new HashMap<>();
		Member principal = (Member) authentication.getPrincipal();
		param.put("memberNo", principal.getMemberNo());
		Address address = mypageService.selectOneAddressByTitle(param);
		log.debug("address = {}", address);
		map.put("available", address == null);
		
		return map;
	}
	
	/**
	 * 주소 등록
	 * insert into address values(seq_address_no.nextval, #{memberNo}, #{postalCode}, #{address1}, #{address2}, #{mainYn}, #{title}, #{addressee}, #{phone})
	 */
	@PostMapping("/myinfo/addressEnroll.do")
	public String addressEnroll(Address address, RedirectAttributes redirectAttr) {
		
		try {
			if(address.getMainYn().equals("Y")) {
				log.debug("address.getMainYn() = {}", address.getMainYn());
				int memberNo = address.getMemberNo();
				int _result = mypageService.updateMainAddress(memberNo);
				log.debug("_result = {}", _result);
			}
			int result = mypageService.insertAddress(address);
			String msg = result > 0 ? "주소 등록이 완료되었습니다." : "주소 등록에 실패하였습니다.";
			redirectAttr.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			log.error("주소 등록 오류", e);
			throw e;
		}
		return "redirect:/mypage/myinfo/addressManage.do";
		
	}
	
	/**
	 * 주소 수정
	 */
	@PostMapping("/myinfo/addressUpdate.do")
	public String addressUpdate(Address address, RedirectAttributes redirectAttr) {

		try {
			if(address.getMainYn().equals("Y")) {
				log.debug("address.getMainYn() = {}", address.getMainYn());
				int memberNo = address.getMemberNo();
				int _result = mypageService.updateMainAddress(memberNo);
				log.debug("_result = {}", _result);
			}
			int result = mypageService.updateAddress(address);
			String msg = result > 0 ? "주소 수정이 완료되었습니다." : "주소 수정에 실패하였습니다.";
			redirectAttr.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			log.error("주소 수정 오류", e);
			throw e;
		}
		return "redirect:/mypage/myinfo/addressManage.do";
		
	}
	
	/**
	 * 주소 삭제
	 */
	@PostMapping("/myinfo/addressDelete.do")
	public String addressDelete(Address address, RedirectAttributes redirectAttr) {

		try {
			int result = mypageService.deleteAddress(address);
			String msg = result > 0 ? "주소 삭제가 완료되었습니다." : "주소 삭제에 실패하였습니다.";
			redirectAttr.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			log.error("주소 삭제 오류", e);
			throw e;
		}
		return "redirect:/mypage/myinfo/addressManage.do";
		
	}
	/**
	 * 지원 나의 정보 > 배송지 관리 끝
	 */
	
	/**
	 * 지원 나의 정보 > 신고 내역 시작
	 */
	@GetMapping("/myinfo/reportHistory.do")
	public String reportHistory(@RequestParam(defaultValue = "1") int cPage, Authentication authentication,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			Member member = (Member) authentication.getPrincipal();
			int memberNo = member.getMemberNo();
			
			//1. 전체 신고 내역
			List<Report> reportList = reportService.selectAllReportByMemberNo(memberNo, offset, limit);
			model.addAttribute("reportList", reportList);
			log.debug("reportList = {}", reportList);
			
			//2. 전체 신고 수 totalContent
			int totalContent = reportService.selectReportTotalCount(memberNo);
			model.addAttribute("totalContent", totalContent);
			
			//3. pagebar
			String url = request.getRequestURI(); // /spring/board/boardList.do
			String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
			
		} catch (Exception e) {
			log.error("신고 내역 조회 오류", e);
			throw e;
		}
		return "mypage/reportHistory";
		
	}
	/**
	 * 지원 나의 정보 > 신고 내역 끝
	 */

	/**
	 * 지원 나의 커뮤니티 > 내가 쓴 글 시작
	 */
	@GetMapping("/mycommunity/postList.do")
	public String postList(@RequestParam(defaultValue = "1") int cPage, Authentication authentication,
			HttpServletRequest request, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			Member member = (Member) authentication.getPrincipal();
			int memberNo = member.getMemberNo();
		
			/* 커뮤니티 내가 쓴 글 */
			//1. 포스팅 내역
			List<CommunityEntity> postList = communityService.selectAllPostOrderByLatest(memberNo, offset, limit);
			model.addAttribute("postList", postList);
			log.debug("postList = {}", postList);
			
			//2. 전체 포스팅 수 totalContent
			int totalContent = communityService.selectPostTotalCount(memberNo);
			model.addAttribute("totalContent", totalContent);
			
			//3. pagebar
			String url = request.getRequestURI(); // /spring/board/boardList.do
			String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
		
		} catch (Exception e) {
			log.error("커뮤니티 포스팅 내역 조회 오류", e);
			throw e;
		}
		return "mypage/postlist";
	}
	
	/**
	 * 포스팅 내역 옵션별 정렬
	 */
	@ResponseBody
	@GetMapping("/mycommunity/selectPostList/{selectType}")
	public Map<String, Object> postListOrderBySelectType(@PathVariable String selectType, @RequestParam(defaultValue = "1") int cPage,
			Authentication authentication, HttpServletRequest request){
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		Member member = (Member) authentication.getPrincipal();
		param.put("memberNo", member.getMemberNo());
		param.put("selectType", selectType);
		log.debug("param = {}", param);
		
		List<CommunityEntity> postListOrderBySelectType = communityService.selectAllPostOrderBySelectType(param, offset, limit);
		
		String url = request.getRequestURI();
		String postListStr = CommunityUtils.getPostListOrderBySelectType(postListOrderBySelectType, url);
		map.put("postListStr", postListStr);
		
		return map;
	}
	/**
	 * 지원 나의 커뮤니티 > 내가 쓴 글 끝
	 */
	
	/**
	 * 지원 나의 커뮤니티 > 좋아요 시작
	 */
	@GetMapping("/mycommunity/likeList.do")
	public String likeList(@RequestParam(defaultValue = "1") int cPage, Authentication authentication,
			HttpServletRequest request, Model model) {
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			Member member = (Member) authentication.getPrincipal();
			int memberNo = member.getMemberNo();
			
			//1. 커뮤니티 좋아요 내역
			List<CommunityEntity> likeList = communityService.selectAllLikeOrderByLatest(memberNo, offset, limit);
			model.addAttribute("likeList", likeList);
			log.debug("likeList = {}", likeList);
			
			//2. 전체 좋아요 수 totalContent
			int totalContent = communityService.selectLikeTotalCount(memberNo);
			model.addAttribute("totalContent", totalContent);
			
			//3. pagebar
			String url = request.getRequestURI();
			String pagebar = DevrunUtils.getPagebar(cPage, limit, totalContent, url);
			log.debug("pagebar = {}", pagebar);
			model.addAttribute("pagebar", pagebar);
		
		} catch (Exception e) {
			log.error("커뮤니티 좋아요 내역 조회 오류", e);
			throw e;
		}
		return "mypage/likelist";
	}
	
	/**
	 * 좋아요 내역 옵션별 정렬
	 */
	@ResponseBody
	@GetMapping("/mycommunity/selectLikeList/{selectType}")
	public Map<String, Object> likeListOrderBySelectType(@PathVariable String selectType, @RequestParam(defaultValue = "1") int cPage,
			Authentication authentication, HttpServletRequest request){
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		
		Member member = (Member) authentication.getPrincipal();
		param.put("memberNo", member.getMemberNo());
		param.put("selectType", selectType);
		log.debug("param = {}", param);
		
		List<CommunityEntity> likeListOrderBySelectType = communityService.selectAllLikeOrderBySelectType(param, offset, limit);
		
		String url = request.getRequestURI();
		String likeListStr = CommunityUtils.getLikeListOrderBySelectType(likeListOrderBySelectType, url);
		map.put("likeListStr", likeListStr);
		
		return map;
	}
	/**
	 * 지원 나의 커뮤니티 > 좋아요 끝
	 */
	
	/**
	 * 지원 끝
	 */
	
	/**
	 * 혜진 나의 쇼핑 시작
	 */
	
	@GetMapping("/myshopping.do")
	public void myshopping(Authentication authentication, Model model) {
		Member member = (Member)authentication.getPrincipal();
		Map<String, Object> map = orderService.selectMyShopping(member.getMemberNo());
		model.addAttribute("orderLogCnt", map.get("orderLogCnt"));
		model.addAttribute("orderList", map.get("orderList"));
	}
	
	/**
	 * 혜진 나의 쇼핑 끝
	 */
	/**
	 * 혜진 교환/환불/취소 리스트 시작
	 */
	
	@GetMapping("/changeOrderList.do")
	public void changeOrderList(Authentication authentication, Model model) {
		Member member = (Member)authentication.getPrincipal();
		List<OrderLogExt> list = orderService.selectOrderLogList(member.getMemberNo());
		model.addAttribute("list", list);
		
	}
	
	/**
	 * 혜진 교환/환불/취소 리스트 끝
	 */
	/**
	 * 혜진 구매확정 리스트 시작
	 */
	
	@GetMapping("/clearOrder.do")
	public String clearOrder(@RequestParam String merchantUid, RedirectAttributes redirectAttr){
		log.debug("merchantUid = {}", merchantUid);

		int result = orderService.clearOneMerchant(merchantUid);
		
		redirectAttr.addFlashAttribute("msg", "구매 확정이 완료되었습니다.");
		
		return "redirect:/mypage/orderList.do";
	}
	
	/**
	 * 혜진 구매확정 리스트 끝
	 */
	/**
	 * 혜진 교환/환불/취소 시작
	 */
	
	@GetMapping("/changeOrder")
	public void changeOrder(@RequestParam String merchantUid, Model model){
		log.debug("merchantUid = {}", merchantUid);

		Map<String, Object> map = orderService.selectOneMerchant(merchantUid);
		model.addAttribute("merchant", map.get("merchant"));
		model.addAttribute("productList", map.get("list"));
		model.addAttribute("imp", map.get("imp"));
	}
	
	/**
	 * 혜진 교환/환불/취소 끝
	 */
	/**
	 * 혜진 주문 내역 시작
	 */
	
	@GetMapping("/orderList.do")
	public void orderList(Authentication auth, Model model) {
		Member member = (Member)auth.getPrincipal();
		List<MerchantExt> list = orderService.selectOrderList(member.getMemberNo());
		
		model.addAttribute("list", list);
	}
	
	/**
	 * 혜진 주문 내역 끝
	 */
	/**
	 * 혜진 주문 상세 시작
	 */
	
	@GetMapping("/orderDetail/{merchantUid}")
	public String orderDetail(@PathVariable String merchantUid, Model model) {
		log.debug("merchantUid = {}", merchantUid);
		Map<String, Object> map = orderService.selectOneMerchant(merchantUid);
		model.addAttribute("merchant", map.get("merchant"));
		model.addAttribute("list", map.get("list"));
		model.addAttribute("imp", map.get("imp"));
		if(map.get("shipment") != null) {
			Shipment shipment = (Shipment)map.get("shipment");
			model.addAttribute("shipment", shipment);
		}
		log.debug("list = {}", map.get("list"));
		return "/mypage/orderDetail";
	}
	
	/**
	 * 혜진 주문 상세 끝
	 */
	/**
	 * 혜진 나의 리뷰 시작
	 */
	
	@GetMapping("/myReview.do")
	public void myReview() {}
	
	/**
	 * 혜진 나의 리뷰 끝
	 */
	/**
	 * 혜진 나의 문의 시작
	 */
	
	@GetMapping("/myQuestion.do")
	public void myQuestion() {}
	
	/**
	 * 혜진 나의 문의 끝
	 */
	/**
	 * 혜진 나의 포인트 조회 시작
	 */
	
	@GetMapping("/myPoint.do")
	public void myPoint() {}
	
	/**
	 * 혜진 나의 포인트 조회 끝
	 */
}