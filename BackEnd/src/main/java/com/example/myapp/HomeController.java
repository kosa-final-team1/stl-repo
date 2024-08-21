package com.example.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import com.example.myapp.outfit.model.Outfit;
import com.example.myapp.outfit.service.IOutfitService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private IOutfitService outfitService;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

		// Outfit 데이터를 가져와서 모델에 추가
		List<Outfit> outfits = outfitService.getRandomOutfits();
		model.addAttribute("outfits", outfits);

		return "home";
	}

}