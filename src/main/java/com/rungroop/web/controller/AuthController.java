package com.rungroop.web.controller;

import com.rungroop.web.dto.RegistrationDto;
import com.rungroop.web.model.User;
import com.rungroop.web.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AuthController {

    private UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/register")
    public String getRegisterForm(Model model) {
        RegistrationDto user = new RegistrationDto();
        model.addAttribute("user", user);
        return "register";
    }

    @GetMapping("/register/fj230fh34g80h30w58yg")
    public String getRegisterFormAdmin(Model model) {
        RegistrationDto user = new RegistrationDto();
        model.addAttribute("user", user);
        return "register-admin";
    }

    @PostMapping("/register/save")
    public String register(@Valid @ModelAttribute("user") RegistrationDto user,
                           BindingResult result, Model model) {
        User existingUserEmail = userService.findByEmail(user.getEmail());
        if (existingUserEmail != null
                && existingUserEmail.getEmail() != null
                && !existingUserEmail.getEmail().isEmpty()) {
            return "redirect:/register?fail";
        }

        User existingUserUsername = userService.findByUsername(user.getUsername());
        if (existingUserUsername != null
                && existingUserUsername.getUsername() != null
                && !existingUserUsername.getUsername().isEmpty()) {
            return "redirect:/register?fail";
        }

        if (result.hasErrors()) {
            model.addAttribute("user", user);
            return "register";
        }

        userService.saveUser(user);
        return "redirect:/clubs?success";
    }

    @PostMapping("/register/fj230fh34g80h30w58yg/save")
    public String registerAdmin(@Valid @ModelAttribute("user") RegistrationDto user,
                           BindingResult result, Model model) {
        User existingUserEmail = userService.findByEmail(user.getEmail());
        if (existingUserEmail != null
                && existingUserEmail.getEmail() != null
                && !existingUserEmail.getEmail().isEmpty()) {
            return "redirect:/register?fail";
        }

        User existingUserUsername = userService.findByUsername(user.getUsername());
        if (existingUserUsername != null
                && existingUserUsername.getUsername() != null
                && !existingUserUsername.getUsername().isEmpty()) {
            return "redirect:/register?fail";
        }

        if (result.hasErrors()) {
            model.addAttribute("user", user);
            return "register";
        }

        userService.saveUserAdmin(user);
        return "redirect:/clubs?success_admin";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

}
