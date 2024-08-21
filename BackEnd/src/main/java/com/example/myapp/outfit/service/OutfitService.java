package com.example.myapp.outfit.service;

import com.example.myapp.outfit.dao.IOutfitRepository;
import com.example.myapp.outfit.model.Outfit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OutfitService implements IOutfitService {

    @Autowired
    private IOutfitRepository outfitRepository;

    @Override
    public List<Outfit> getRandomOutfits() {
        return outfitRepository.getRandomOutfits();
    }

    @Override
    public Outfit getOutfitDetails(String weatherNo, String styleNo, int styleIdx) {
        return outfitRepository.getOutfitDetails(weatherNo, styleNo, styleIdx);
    }
}