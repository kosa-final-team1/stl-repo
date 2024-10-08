package com.example.myapp.user.service;

import com.example.myapp.user.model.User;

public interface IUserService {

    User getUser(String userId, String userPw);
    boolean signUpUser(User user);
    int getUserId(String userId);
    boolean updateUser(User user);
    boolean deleteUser(String userId);
    boolean updatePassword(String userId, String currentPassword, String newPassword);
	User getUserStyleNo(String userId);
	
}