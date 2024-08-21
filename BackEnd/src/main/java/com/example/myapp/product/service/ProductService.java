package com.example.myapp.product.service;

import com.example.myapp.product.dao.IProductRepository;
import com.example.myapp.product.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService implements IProductService {

    @Autowired
    private IProductRepository productRepository;

    @Override
    public List<Product> getProductsForOutfit(String weatherNo, String styleNo, int styleIdx) {
        return productRepository.findProductsByOutfit(weatherNo, styleNo, styleIdx);
    }
}