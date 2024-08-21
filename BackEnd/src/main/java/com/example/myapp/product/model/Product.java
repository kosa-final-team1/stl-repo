package com.example.myapp.product.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Product {
    private String productUrl;
    private String productBrand;
    private String productName;
    private String productPrice;

    @Override
    public String toString() {
        return "Product{" +
                "productUrl='" + productUrl + '\'' +
                ", productBrand='" + productBrand + '\'' +
                ", productName='" + productName + '\'' +
                ", productPrice='" + productPrice + '\'' +
                '}';
    }

}