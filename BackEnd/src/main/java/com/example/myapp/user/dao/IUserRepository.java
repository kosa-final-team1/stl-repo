package com.example.myapp.user.dao;

import com.example.myapp.user.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface IUserRepository {

    // ID, PW로 USER 정보 조회하기
    User getUser(@Param("userId") String userId, @Param("userPw") String userPw);

    // 회원가입
    boolean signUpUser(User user);

    int getUserId(String userId);

    User getUser(Map<String, Object> params);

    int updateUser(User user);

    int deleteUser(String userId);
}