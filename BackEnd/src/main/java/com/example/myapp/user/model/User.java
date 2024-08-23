package com.example.myapp.user.model;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@Setter
public class User {
    private int userNo;

    @NotNull
    @Size(min = 5, max = 15, message = "ID는 5자부터 15자 내로 만들어주세요.")
    private String userId;

    @NotNull
    @Size(min = 8, max = 15, message = "PASSWORD는 8자부터 15자 내로 만들어주세요.")
    private String userPw;

    private String gender;
    private int age;
    @NotNull(message = "Style must be selected.")
    private String styleNo;
    private String styleName;

    public String getStyleNo() {
        return styleNo;
    }

    public void setStyleNo(String styleNo) {
        this.styleNo = styleNo;
    }

}