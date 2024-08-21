package com.example.myapp.outfit.service;

import com.example.myapp.outfit.model.Outfit;

import java.util.List;

public interface IOutfitService {
    List<Outfit> getRandomOutfits();

    Outfit getOutfitDetails(String weatherNo, String styleNo, int styleIdx);
}