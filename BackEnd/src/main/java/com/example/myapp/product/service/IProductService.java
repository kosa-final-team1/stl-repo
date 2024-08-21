package com.example.myapp.product.service;

import com.example.myapp.product.model.Product;

import java.util.List;

public interface IProductService {
    List<Product> getProductsForOutfit(String weatherNo, String styleNo, int styleIdx);
}