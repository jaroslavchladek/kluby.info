package com.rungroop.web.mapper;

import com.rungroop.web.dto.ClubDto;
import com.rungroop.web.model.Club;

import java.util.stream.Collectors;

import static com.rungroop.web.mapper.EventMapper.mapToEventDto;

public class ClubMapper {

    public static Club mapToClub(ClubDto clubDto) {
        Club club = Club.builder()
                .id(clubDto.getId())
                .title(clubDto.getTitle())
                .photoUrl(clubDto.getPhotoUrl())
                .content(clubDto.getContent())
                .createdOn(clubDto.getCreatedOn())
                .createdBy(clubDto.getCreatedBy())
                .updatedOn(clubDto.getUpdatedOn())
                .locationMapLink(clubDto.getLocationMapLink())
                .build();
        return club;
    }

    public static ClubDto mapToClubDto(Club club) {
        ClubDto clubDto = ClubDto.builder()
                .id(club.getId())
                .title(club.getTitle())
                .photoUrl(club.getPhotoUrl())
                .content(club.getContent())
                .createdOn(club.getCreatedOn())
                .createdBy(club.getCreatedBy())
                .updatedOn(club.getUpdatedOn())
                .locationMapLink(club.getLocationMapLink())
                .events(club.getEvents().stream().map((event) -> mapToEventDto(event)).collect(Collectors.toList()))
                .build();
        return clubDto;
    }

}
