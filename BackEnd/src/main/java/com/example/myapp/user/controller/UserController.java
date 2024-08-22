package com.example.myapp.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.myapp.user.model.User;
import com.example.myapp.user.service.IUserService;

@Controller
public class UserController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    IUserService userService;

    // 예외 처리 핸들러: DB 오류 발생 시 오류 페이지로 이동
    @ExceptionHandler({RuntimeException.class})
    public String runtimeException(HttpServletRequest request, Exception ex, Model model) {
        logger.error("DB Error: URL-{}, EX-{} ", request.getRequestURL(), ex);
        model.addAttribute("exception", ex);
        model.addAttribute("url", request.getRequestURL());
        return "error/runtime";
    }

    // 회원가입 페이지 표시
    @GetMapping("/user/signup")
    public String showSignUpForm(Model model) {
        model.addAttribute("user", new User());
        return "signup";
    }

    // 회원가입 처리 및 유효성 검사
    @PostMapping("/user/signup")
    public String signUp(@Valid @ModelAttribute("user") User user, BindingResult result,
                         RedirectAttributes redirectAttributes,
                         HttpServletRequest request, Model model) {
        logger.info(">>> SignUp 시작");

        // 유효성 검증 오류 처리
        if (result.hasErrors()) {
            logger.info(">>> 유효성 검사 실패: " + result.getAllErrors());
            return "signup";
        }

        // 선택된 스타일 번호들을 수집하여 User 객체에 설정
        String selectedStyles = request.getParameter("styleNo");
        if (selectedStyles == null || selectedStyles.isEmpty()) {
            logger.info(">>> 스타일 번호가 비어 있음");
            model.addAttribute("styleError", "적어도 하나의 패션 스타일을 선택해야 합니다.");
            return "signup";
        } else {
            user.setStyleNo(selectedStyles);
        }

        try {
            int existUserId = userService.getUserId(user.getUserId());
            logger.info(">>>> 회원가입 시 사용자 ID 여부 확인 : " + existUserId);
            if (existUserId == 0) {
                boolean isSignUpSuccessful = userService.signUpUser(user);
                logger.info(">>> 회원가입 정보 입력 : " + isSignUpSuccessful);
                if (isSignUpSuccessful) {
                    logger.info(">>> 회원가입 성공 ");
                    redirectAttributes.addFlashAttribute("message", "회원가입이 완료되었습니다. 로그인해주세요.");
                    return "redirect:/user/login";
                } else {
                    logger.info(">>> 회원가입 실패 ");
                    redirectAttributes.addFlashAttribute("message", "회원가입에 실패했습니다. 다시 시도해주세요.");
                    return "redirect:/user/signup";
                }
            } else {
                logger.info(">>> 기존 사용자 ID 있음 -> 회원가입 불가");
                redirectAttributes.addFlashAttribute("message", "기존 사용자 ID가 있어 회원가입이 불가합니다.");
                return "redirect:/user/signup";
            }
        } catch (RuntimeException e) {
            logger.error("회원가입 에러: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("message", "회원가입 시 에러가 발생했습니다.");
            return "redirect:/user/signup";
        }
    }

    // 로그인 페이지 표시
    @GetMapping("/user/login")
    public String showLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "login";
    }

    // 로그인 처리
    @PostMapping("/user/login")
    public String getLogin(@RequestParam String userId,
                           @RequestParam String userPw,
                           HttpSession session,
                           RedirectAttributes redirectAttr) {
        try {
            // 사용자 ID 유효성 검사
            if (userId == null || userId.isEmpty()) {
                logger.info(">>> ID 없음");
                redirectAttr.addFlashAttribute("message", "해당 사용자 ID가 존재하지 않습니다.");
                return "redirect:/user/login";
            } else {
                // 사용자 정보 확인
                User userInfo = userService.getUser(userId, userPw);
                logger.info(">>> 조회된 사용자 정보: " + userInfo);
                if (userInfo != null) {
                    logger.info(">>> 데이터베이스에서 가져온 비밀번호: " + userInfo.getUserPw());
                    logger.info(">>> 입력된 비밀번호: " + userPw);

                    // 비밀번호 일치 확인
                    if (userInfo.getUserPw().equals(userPw)) {
                        logger.info(">>> 비밀번호 맞음");

                        // 세션에 값 저장 전 기존 값 로그로 확인
                        logger.info(">>> 기존 세션 userId: " + session.getAttribute("userId"));
                        logger.info(">>> 기존 세션 userPw: " + session.getAttribute("userPw"));

                        session.setAttribute("userNo", userInfo.getUserNo());
                        session.setAttribute("userId", userId);
                        session.setAttribute("userPw", userPw); // 세션에 비밀번호 저장

                        // 저장된 후의 값 로그로 확인
                        logger.info(">>> 새로운 세션 userId: " + session.getAttribute("userId"));
                        logger.info(">>> 새로운 세션 userPw: " + session.getAttribute("userPw"));

                        // 로그인 성공 후 홈 페이지로 리다이렉트
                        return "redirect:/";
                    } else {
                        logger.info(">>>> 비밀번호 안 맞음");
                        redirectAttr.addFlashAttribute("message", "비밀번호가 맞지 않습니다.");
                        return "redirect:/user/login";
                    }
                } else {
                    logger.info(">>>> 사용자 정보 없음");
                    redirectAttr.addFlashAttribute("message", "해당 정보가 맞지 않습니다.");
                    return "redirect:/user/login";
                }
            }
        } catch (Exception e) {
            logger.error("로그인 에러: {}", e.getMessage());
            redirectAttr.addFlashAttribute("message", "로그인 시 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return "redirect:/user/login";
        }
    }

    // 로그아웃 처리
    @GetMapping("/user/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttr) {
        redirectAttr.addFlashAttribute("message", "로그아웃 되었습니다.");
        session.invalidate();
        logger.info("로그아웃 되었습니다.");
        return "redirect:/";
    }

    // 마이페이지 표시
    @GetMapping("/user/mypage")
    public String showMyPage(@RequestParam(required = false) String userId, Model model, HttpSession session) {
        String sessionUserId = (String) session.getAttribute("userId"); // 세션에서 userId 가져오기

        if (sessionUserId == null) {
            return "redirect:/user/login"; // 세션에 userId가 없으면 로그인 페이지로 리다이렉트
        }

        // URL 파라미터로 전달된 userId가 있고, 세션의 userId와 다르면 로그인 페이지로 리다이렉트
        if (userId != null && !sessionUserId.equals(userId)) {
            logger.info(">>>> 세션 ID와 URL ID가 일치하지 않음: 세션 ID = " + sessionUserId + ", URL ID = " + userId);
            return "redirect:/user/login";
        }

        User user = userService.getUser(sessionUserId, (String) session.getAttribute("userPw"));
        // 유효한 사용자 정보인지 확인
        if (user != null) {
            model.addAttribute("user", user);
            return "mypage";
        } else {
            logger.info(">>>> 세션에 저장된 사용자 정보가 유효하지 않음");
            session.invalidate(); // 유효하지 않은 세션 정보를 초기화
            return "redirect:/user/login";
        }
    }

    // 사용자 정보 업데이트 처리
    @PostMapping("/user/update")
    public String updateUser(@ModelAttribute User user, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            String sessionUserId = (String) session.getAttribute("userId"); // 세션에서 userId 가져오기
            if (sessionUserId != null) {
                user.setUserId(sessionUserId); // 세션의 userId로 설정
                boolean isUpdateSuccessful = userService.updateUser(user);
                if (isUpdateSuccessful) {
                    redirectAttributes.addFlashAttribute("message", "정보가 성공적으로 업데이트되었습니다.");
                    return "redirect:/user/mypage";
                } else {
                    redirectAttributes.addFlashAttribute("message", "정보 업데이트에 실패했습니다.");
                    return "redirect:/user/mypage";
                }
            } else {
                return "redirect:/user/login";
            }
        } catch (Exception e) {
            logger.error("업데이트 에러: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("message", "정보 업데이트 시 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return "redirect:/user/mypage";
        }
    }

    // 사용자 계정 삭제 처리 (회원 탈퇴)
    @PostMapping("/user/delete")
    public String deleteUser(@RequestParam String userPw, HttpSession session,
                             RedirectAttributes redirectAttributes) {
        String sessionUserId = (String) session.getAttribute("userId"); // 세션에서 userId 가져오기
        User user = userService.getUser(sessionUserId, userPw);

        if (user != null) {
            boolean isDeleteSuccessful = userService.deleteUser(sessionUserId);
            if (isDeleteSuccessful) {
                session.invalidate();
                redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");
                return "redirect:/user/login";
            } else {
                redirectAttributes.addFlashAttribute("message", "회원 탈퇴에 실패했습니다.");
                return "redirect:/user/mypage";
            }
        } else {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 일치하지 않습니다.");
            return "redirect:/user/mypage";
        }
    }
}