package com.example.myapp.outfit.dao;

import com.example.myapp.outfit.model.Outfit;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IOutfitRepository {

    List<Outfit> getRandomOutfits();

    // [0825 김제이 추가]
    // *기능설명: 로그인 사용 styleNo split 후 조회
    List<Outfit> getRecommandOutfits(@Param("userId") String userId,
						    		@Param("firstValue") String firstValue,
						    		@Param("secondValue") String secondValue,
						    		@Param("thirdValue") String thirdValue
						    		);

    Outfit getOutfitDetails(@Param("weatherNo") String weatherNo,
                            @Param("styleNo") String styleNo,
                            @Param("styleIdx") int styleIdx);

    List<Outfit> getOutfitsByStyleNo(@Param("styleNo") String styleNo);

    List<Outfit> getOutfitsByStyleName(@Param("styleName") String styleName);
    List<Outfit> getOutfitsByStyleNoAndGender(@Param("styleNo") String styleNo, @Param("gender") String gender);
}