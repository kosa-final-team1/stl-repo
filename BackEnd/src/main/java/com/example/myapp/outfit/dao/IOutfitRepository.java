package com.example.myapp.outfit.dao;

import com.example.myapp.outfit.model.Outfit;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IOutfitRepository {

    List<Outfit> getRandomOutfits();

    Outfit getOutfitDetails(@Param("weatherNo") String weatherNo,
                            @Param("styleNo") String styleNo,
                            @Param("styleIdx") int styleIdx);

}