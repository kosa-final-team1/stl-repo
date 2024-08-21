package com.example.myapp.product.dao;

import com.example.myapp.product.model.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IProductRepository {
    List<Product> findProductsByOutfit(@Param("weatherNo") String weatherNo,
                                       @Param("styleNo") String styleNo,
                                       @Param("styleIdx") int styleIdx);
}