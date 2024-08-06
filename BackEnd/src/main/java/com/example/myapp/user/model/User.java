package com.example.myapp.user.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {

    private int userNo;
    private String userId;
    private String userPw;
    private String gender;
    private int age;
    private String prefType;
}