package com.example.myapp.user.dao;

import com.example.myapp.user.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface IUserRepository {

    // ID, PW로 USER 정보 조회하기
    User getUser(@Param("user_id") String user_id, @Param("user_pw") String user_pw);

    // 회원가입
    boolean signUpUser(User user);

    int getUserId(String user_id);

    User getUser(Map<String, Object> params);

    int updateUser(User user);

    int deleteUser(String userId);
}
