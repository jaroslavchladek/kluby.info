package com.rungroop.web.service.impl;

import com.rungroop.web.dto.RegistrationDto;
import com.rungroop.web.model.*;
import com.rungroop.web.repository.ClubRepository;
import com.rungroop.web.repository.EventRepository;
import com.rungroop.web.repository.RoleRepository;
import com.rungroop.web.repository.UserRepository;
import com.rungroop.web.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;
    private ClubRepository clubRepository;
    private EventRepository eventRepository;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void saveUser(RegistrationDto registrationDto) {
        User user = new User();
        user.setUsername(registrationDto.getUsername());
        user.setEmail(registrationDto.getEmail());
        user.setPassword(passwordEncoder.encode(registrationDto.getPassword()));
        Role role = new Role(null, "USER", List.of(user));
        user.setRoles(List.of(role));
        userRepository.save(user);
    }

    @Override
    public void saveUserAdmin(RegistrationDto registrationDto) {
        User user = new User();
        user.setUsername(registrationDto.getUsername());
        user.setEmail(registrationDto.getEmail());
        user.setPassword(passwordEncoder.encode(registrationDto.getPassword()));
        Role role = new Role(null, "USER", List.of(user));
        Role adminRole = new Role(null, "ADMIN", List.of(user));
        user.setRoles(List.of(role, adminRole));
        userRepository.save(user);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public void addClubLike(Club club, User user, Long likeValue) {
        // Get the club like
        List<ClubLike> likes = user.getClubLikes();
        ClubLike clubLike = new ClubLike(new Random().nextLong(), club, likeValue);

        // Edit club likes
        likes = likes.stream()
                .filter(like -> !like.getClub().getId().equals(club.getId()))
                .collect(Collectors.toList());
        likes.add(clubLike);
        user.setClubLikes(likes);

        userRepository.save(user);
    }

    @Override
    public void addEventLike(Event event, User user, Long likeValue) {
        // Get the event like
        List<EventLike> likes = user.getEventLikes();
        EventLike eventLike = new EventLike(new Random().nextLong(), event, likeValue);

        // Edit event likes
        likes = likes.stream()
                .filter(like -> !like.getEvent().getId().equals(event.getId()))
                .collect(Collectors.toList());
        likes.add(eventLike);
        user.setEventLikes(likes);

        userRepository.save(user);
    }

}
