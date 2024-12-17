package com.rungroop.web.service;

import com.rungroop.web.dto.RegistrationDto;
import com.rungroop.web.model.Club;
import com.rungroop.web.model.Event;
import com.rungroop.web.model.User;

public interface UserService {

    public static final Long LIKE_VALUE = 1L;
    public static final Long DISLIKE_VALUE = -1L;

    void saveUser(RegistrationDto registrationDto);
    void saveUserAdmin(RegistrationDto registrationDto);
    User findByEmail(String email);
    User findByUsername(String username);
    void addClubLike(Club club, User user, Long likeValue);
    void addEventLike(Event event, User user, Long likeValue);
}
