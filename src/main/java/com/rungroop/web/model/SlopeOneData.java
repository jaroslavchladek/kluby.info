package com.rungroop.web.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.rungroop.web.model.Club;
import com.rungroop.web.model.Event;
import com.rungroop.web.model.User;
import jakarta.persistence.*;
import lombok.*;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "slope_one_data")
public class SlopeOneData {

    @Id
    private Long id = 1L;

    @Lob
    private String clubRecommendationMatrixJson;

    @Lob
    private String eventRecommendationMatrixJson;

    // Uses User IDs then Club IDs
    @Transient
    private Map<Long, HashMap<Long, Double>> clubRecommendationMatrix = new HashMap<>();

    @Transient
    private Map<Long, HashMap<Long, Double>> eventRecommendationMatrix = new HashMap<>();

    // Serialization helper
    public void serializeMatrices() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        this.clubRecommendationMatrixJson = mapper.writeValueAsString(clubRecommendationMatrix);
        this.eventRecommendationMatrixJson = mapper.writeValueAsString(eventRecommendationMatrix);
    }

    // Deserialization helper
    public void deserializeMatrices() throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        if (clubRecommendationMatrixJson != null) {
            this.clubRecommendationMatrix = mapper.readValue(clubRecommendationMatrixJson, new TypeReference<>() {});
        }
        if (eventRecommendationMatrixJson != null) {
            this.eventRecommendationMatrix = mapper.readValue(eventRecommendationMatrixJson, new TypeReference<>() {});
        }
    }

}

