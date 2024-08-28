package com.example.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import com.example.myapp.outfit.model.Outfit;
import com.example.myapp.outfit.service.IOutfitService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private IOutfitService outfitService;

	@GetMapping("/")
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

		String loginId = (String) session.getAttribute("userId");
		String styleNumbers = (String) session.getAttribute("styleNo");
		String gender = (String) session.getAttribute("gender");  // 세션에서 gender 가져오기

		if (loginId == null || loginId.isEmpty()) {
			// 사용자가 로그인하지 않은 경우, 랜덤 코디를 표시
			List<Outfit> randomOutfits = outfitService.getRandomOutfits();
			model.addAttribute("outfits", randomOutfits);
		} else {
			// 사용자가 로그인한 경우, 스타일 번호 및 성별에 따라 추천 코디를 표시
			String[] styleArray = styleNumbers != null ? styleNumbers.split(",") : new String[0];

			if (styleArray.length > 0) {
				List<Outfit> firstStyleOutfits = outfitService.getOutfitsByStyleNoAndGender(styleArray[0], gender);
				model.addAttribute("firstStyleOutfits", firstStyleOutfits);
				model.addAttribute("firstStyleName", firstStyleOutfits.isEmpty() ? "" : firstStyleOutfits.get(0).getStyleName());
			}
			if (styleArray.length > 1) {
				List<Outfit> secondStyleOutfits = outfitService.getOutfitsByStyleNoAndGender(styleArray[1], gender);
				model.addAttribute("secondStyleOutfits", secondStyleOutfits);
				model.addAttribute("secondStyleName", secondStyleOutfits.isEmpty() ? "" : secondStyleOutfits.get(0).getStyleName());
			}
			if (styleArray.length > 2) {
				List<Outfit> thirdStyleOutfits = outfitService.getOutfitsByStyleNoAndGender(styleArray[2], gender);
				model.addAttribute("thirdStyleOutfits", thirdStyleOutfits);
				model.addAttribute("thirdStyleName", thirdStyleOutfits.isEmpty() ? "" : thirdStyleOutfits.get(0).getStyleName());
			}
		}

		return "home";
	}
}