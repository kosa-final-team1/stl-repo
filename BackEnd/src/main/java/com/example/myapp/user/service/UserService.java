package com.example.myapp.user.service;

import com.example.myapp.user.dao.IUserRepository;
import com.example.myapp.user.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService implements IUserService {

    @Autowired
    IUserRepository userRepository;

    @Override
    public User getUser(String userId, String userPw) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        params.put("userPw", userPw);
        return userRepository.getUser(params);
    }
    

    @Override
    public User getUserStyleNo(String userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        return userRepository.getUserStyleNo(params);
    }
    
    @Override
    @Transactional
    public boolean signUpUser(User user) {
        return userRepository.signUpUser(user);
    }

    @Override
    public int getUserId(String userId) {
        return userRepository.getUserId(userId);
    }

    @Override
    @Transactional
    public boolean updateUser(User user) {
        int rowsAffected = userRepository.updateUser(user);
        return rowsAffected > 0; // 업데이트된 행의 수가 1 이상이면 성공
    }

    @Override
    @Transactional
    public boolean deleteUser(String userId) {
        return userRepository.deleteUser(userId) > 0;
    }

    @Override
    @Transactional
    public boolean updatePassword(String userId, String currentPassword, String newPassword) {
        User user = getUser(userId, currentPassword);
        if (user != null) {
            user.setUserPw(newPassword); // 새 비밀번호로 설정
            return updateUser(user); // updateUser 메서드를 통해 업데이트 수행
        }
        return false; // 현재 비밀번호가 맞지 않으면 false 반환
    }
}