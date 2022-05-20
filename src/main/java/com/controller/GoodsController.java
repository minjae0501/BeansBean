package com.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.MemberDTO;
import com.service.GoodsService;

@Controller
public class GoodsController {
	
	@Autowired
	GoodsService service;
	
	@RequestMapping("/goodsList")
	public ModelAndView goodsList(String gcategory) {
		// TODO 상품목록보기
//		System.out.println(gcategory);
		if(gcategory == null) {

			gcategory = "coffee";

		}

		List<GoodsDTO> list = service.goodsList(gcategory);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("goodsList", list);
//		System.out.println(list);
		mav.setViewName("main");
		return mav;
	}
	
	@RequestMapping("/goodsDetail")
	@ModelAttribute("goodsDetail")
	public GoodsDTO goodsDetail(String gcode) {
//		System.out.println(gcode);
		GoodsDTO dto = service.goodsDetail(gcode);
//		System.out.println(dto);
		return dto;
	}
	
	@RequestMapping("/loginCheck/cartAdd")
	public String cartAdd(CartDTO cart, HttpSession session) {
		MemberDTO mDTO= (MemberDTO)session.getAttribute("login");
		
		cart.setUserid(mDTO.getUserid());
		
		session.setAttribute("mesg", cart.getGcode());
		service.cartAdd(cart);
		return "redirect:../goodsDetail?gcode="+cart.getGcode();
	}

	@RequestMapping("/loginCheck/cartList")
	public String cartList(RedirectAttributes attr, HttpSession session) {
		MemberDTO dto= (MemberDTO)session.getAttribute("login");
		String userid=dto.getUserid();
		List<CartDTO> list =service.cartList(userid);
		attr.addFlashAttribute("cartList", list);
		return "redirect:../cartList"; //servlet-context에 등록
		
	}

	@RequestMapping(value = "/loginCheck/cartDelete")
	@ResponseBody
	public void cartDelte(@RequestParam("num") int num) {
		System.out.println(num);
		service.cartDelete(num);
	}
	
	@RequestMapping(value = "/loginCheck/delAllCart")
	public String delAllCart(@RequestParam("check") ArrayList<String> list) {
		System.out.println(list);
		service.delAllCart(list);
		return "redirect:../loginCheck/cartList";
	}
	
	
	@RequestMapping(value = "/loginCheck/cartUpdate")
	@ResponseBody
	public void cartUpdate(@RequestParam Map<String, String>map) {
		System.out.println(map); //
		service.cartUpdate(map);
	}

}
