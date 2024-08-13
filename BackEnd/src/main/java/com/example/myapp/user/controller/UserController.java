package com.example.myapp.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.myapp.user.model.User;
import com.example.myapp.user.service.IUserService;

@Controller
public class UserController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    IUserService userService;

    @ExceptionHandler({RuntimeException.class})
    public String runtimeException(HttpServletRequest request, Exception ex, Model model) {
        logger.error("DB Error: URL-{}, EX-{} ", request.getRequestURL(), ex);
        model.addAttribute("exception", ex);
        model.addAttribute("url", request.getRequestURL());
        return "error/runtime";
    }

    @GetMapping("/user/signup")
    public String showSignUpForm(Model model) {
        model.addAttribute("user", new User());
        return "signup";
    }

    @PostMapping("/user/signup")
    public String signUp(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            int existUserId = userService.getUserId(user.getUserId());
            logger.info(">>>> 회원가입 시 사용자 ID 여부 확인 : " + existUserId);
            if (existUserId == 0) {
                boolean isSignUpSuccessful = userService.signUpUser(user);
                logger.info(">>> 회원가입 정보 입력 : " + isSignUpSuccessful);
                if (isSignUpSuccessful) {
                    logger.info(">>> 성공 ");
                    redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 로그인해주세요.");
                    return "redirect:/user/login"; // 회원가입 후 로그인 페이지로 이동
                } else {
                    logger.info(">>> 실패 ");
                    redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
                }
            } else {
                logger.info(">>> 기존 사용자 ID 있음 -> 회원가입 불가");
                redirectAttributes.addFlashAttribute("message", "기존 사용자 ID가 있어 회원가입이 불가합니다.");
                return "redirect:/user/signup"; // 이미 있는 아이디인 경우 다시 회원가입 페이지로 이동
            }
        } catch (RuntimeException e) {
            logger.info(">>>> catch문 입성");
            logger.info(">>>" + e.getMessage());
            redirectAttributes.addFlashAttribute("message", "회원가입 시 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return "redirect:/user";
        }
        return "redirect:/user/signup"; // 회원가입 실패 시 다시 회원가입 페이지로 이동
    }

    @GetMapping("/user/login")
    public String showLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "login"; // login.jsp 페이지로 이동
    }

    @PostMapping("/user/login")
    public String getLogin(@RequestParam String userId,
                           @RequestParam String userPw,
                           HttpSession session,
                           RedirectAttributes redirectAttr) {
        try {
            if (userId == null || userId.isEmpty()) {
                logger.info(">>> ID 없음");
                redirectAttr.addFlashAttribute("message", "해당 사용자 ID가 존재하지 않습니다.");
                return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
            } else {
                User userInfo = userService.getUser(userId, userPw);
                logger.info(">>> 조회 완료");
                if (userInfo != null) {
                    if (userInfo.getUserPw().equals(userPw)) {
                        logger.info(">>> 비밀번호 맞음");
                        session.setAttribute("userNo", userInfo.getUserNo());
                        session.setAttribute("userId", userId);
                        return "redirect:/user/mypage"; // 로그인 성공 후 개인정보 수정 페이지로 리다이렉트
                    } else {
                        logger.info(">>>> 비밀번호 안 맞음");
                        redirectAttr.addFlashAttribute("message", "비밀번호가 맞지 않습니다.");
                        return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
                    }
                } else {
                    logger.info(">>>> 사용자 정보 없음");
                    redirectAttr.addFlashAttribute("message", "해당 정보가 맞지 않습니다.");
                    return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
                }
            }
        } catch (Exception e) {
            logger.info(">>> 로그인 시 에러 발생 : " + e.getMessage());
            redirectAttr.addFlashAttribute("message", "로그인 시 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
        }
    }

    @GetMapping("/user/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttr) {
        redirectAttr.addFlashAttribute("message", "로그아웃 되었습니다.");
        session.invalidate();
        logger.info("로그아웃 되었습니다.");
        return "redirect:/user";
    }

    // 마이페이지에서 사용자 정보 수정 폼 표시
    @GetMapping("/user/mypage")
    public String showMyPage(Model model, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        if (userId != null) {
            User user = userService.getUser(userId, (String) session.getAttribute("userPw"));
            model.addAttribute("user", user);
            return "mypage";
        } else {
            return "redirect:/user/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
        }
    }

    // 마이페이지에서 사용자 정보 업데이트 처리
    @PostMapping("/user/update")
    public String updateUser(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String userId = (String) session.getAttribute("userId");
            if (userId != null) {
                user.setUserId(userId);
                boolean isUpdateSuccessful = userService.updateUser(user);
                if (isUpdateSuccessful) {
                    redirectAttributes.addFlashAttribute("message", "정보가 성공적으로 업데이트되었습니다.");
                    return "redirect:/user/mypage";
                } else {
                    redirectAttributes.addFlashAttribute("message", "정보 업데이트에 실패했습니다.");
                    return "redirect:/user/mypage";
                }
            } else {
                return "redirect:/user/login"; // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
            }
        } catch (Exception e) {
            logger.info(">>> 업데이트 시 에러 발생 : " + e.getMessage());
            redirectAttributes.addFlashAttribute("message", "정보 업데이트 시 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return "redirect:/user/mypage"; // 에러 발생 시 마이페이지로 리다이렉트
        }
    }

    @PostMapping("/user/delete")
    public String deleteUser(@RequestParam String userPw, HttpSession session, RedirectAttributes redirectAttributes) {
        String userId = (String) session.getAttribute("userId");
        User user = userService.getUser(userId, userPw);

        if (user != null) {
            boolean isDeleteSuccessful = userService.deleteUser(userId);
            if (isDeleteSuccessful) {
                session.invalidate(); // 로그아웃 처리
                redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
                return "redirect:/user/signup";
            } else {
                redirectAttributes.addFlashAttribute("message", "회원 탈퇴에 실패했습니다.");
                return "redirect:/user/mypage";
            }
        } else {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 틀렸습니다.");
            return "redirect:/user/mypage";
        }
    }
}