package com.example.myapp.product.controller;

import com.example.myapp.outfit.model.Outfit;
import com.example.myapp.outfit.service.IOutfitService;
import com.example.myapp.product.model.Product;
import com.example.myapp.product.service.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller
public class ProductController {

    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    private IProductService productService;

    @Autowired
    private IOutfitService outfitService;

    @GetMapping("/outfitdetail")
    public String showOutfitDetail(@RequestParam("weatherNo") String weatherNo,
                                   @RequestParam("styleNo") String styleNo,
                                   @RequestParam("styleIdx") int styleIdx,
                                   Model model) {
        // Outfit 객체 가져오기
        Outfit outfit = outfitService.getOutfitDetails(weatherNo, styleNo, styleIdx);

        // Product 리스트 가져오기
        List<Product> products = productService.getProductsForOutfit(weatherNo, styleNo, styleIdx);

        // Product 객체 내용 확인
        for (Product product : products) {
            logger.debug("Product: {}", product);
        }

        model.addAttribute("outfit", outfit);
        model.addAttribute("products", products);

        return "outfitdetail";
    }
}