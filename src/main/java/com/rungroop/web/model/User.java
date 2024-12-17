package com.rungroop.web.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String email;
    private String password;
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "user_roles",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id")},
            inverseJoinColumns = {@JoinColumn(name = "role_id", referencedColumnName = "id")}
    )
    private List<Role> roles = new ArrayList<>();
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "user_club_likes",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id")}
    )
    private List<ClubLike> clubLikes = new ArrayList<>();
    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "user_event_likes",
            joinColumns = {@JoinColumn(name = "user_id", referencedColumnName = "id")}
    )
    private List<EventLike> eventLikes = new ArrayList<>();
    @Transient
    private List<Club> recommendedClubs = new ArrayList<>();
    @Transient
    private List<Event> recommendedEvents = new ArrayList<>();
}
