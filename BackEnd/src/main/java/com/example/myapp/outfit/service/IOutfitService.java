package com.example.myapp.outfit.service;

import com.example.myapp.outfit.model.Outfit;

import java.util.List;

public interface IOutfitService {
    List<Outfit> getRandomOutfits();
    Outfit getOutfitDetails(String weatherNo, String styleNo, int styleIdx);
    List<Outfit> getRecommandOutfits(String userId, String firstValue, String secondValue, String thirdValue);
    List<Outfit> getOutfitsByStyleNo(String styleNo);
    List<Outfit> getOutfitsByStyleName(String styleName);
    List<Outfit> getOutfitsByStyleNoAndGender(String styleNo, String gender);
}