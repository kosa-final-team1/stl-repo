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

    // [0825 김제이 추가]
    // *기능설명: 로그인 사용 styleNo split 후 조회쿼리
	@Override
	public List<Outfit> getRecommandOutfits(String userId, String firstValue, String secondValue, String thirdValue) {
        return outfitRepository.getRecommandOutfits(userId, firstValue, secondValue, thirdValue);
	}

	@Override
    public List<Outfit> getOutfitsByStyleNo(String styleNo) {
        return outfitRepository.getOutfitsByStyleNo(styleNo);
    }

    @Override
    public List<Outfit> getOutfitsByStyleName(String styleName) {
        return outfitRepository.getOutfitsByStyleName(styleName);
    }

    @Override
    public List<Outfit> getOutfitsByStyleNoAndGender(String styleNo, String gender) {
        return outfitRepository.getOutfitsByStyleNoAndGender(styleNo, gender);
    }
}