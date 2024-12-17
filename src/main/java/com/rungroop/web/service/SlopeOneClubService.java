package com.rungroop.web.service;

import com.rungroop.web.model.Club;
import com.rungroop.web.model.ClubLike;
import com.rungroop.web.model.SlopeOneData;
import com.rungroop.web.model.User;
import com.rungroop.web.repository.ClubRepository;
import com.rungroop.web.repository.SlopeOneDataRepository;
import com.rungroop.web.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;
import java.util.Map.Entry;
import java.util.stream.Collectors;

/**
 * Slope One algorithm implementation
 */
@Service
public class SlopeOneClubService {

    UserRepository userRepository;
    ClubRepository clubRepository;
    SlopeOneDataRepository slopeOneDataRepository;

    @Autowired
    SlopeOneClubService(UserRepository userRepository, ClubRepository clubRepository,
                        SlopeOneDataRepository slopeOneDataRepository) {
        this.userRepository = userRepository;
        this.clubRepository = clubRepository;
        this.slopeOneDataRepository = slopeOneDataRepository;
    }

    // Uses Club IDs to compute
    private Map<Long, Map<Long, Double>> diff = new HashMap<>();
    private Map<Long, Map<Long, Integer>> freq = new HashMap<>();
    // Uses User IDs then Club IDs to compute
    private Map<Long, HashMap<Long, Double>> inputData;
    private Map<Long, HashMap<Long, Double>> outputData = new HashMap<>();

    private Map<Long, HashMap<Long, Double>> gatherRecommendationScoreMatrices(
            Optional<SlopeOneData> slopeOneData) throws IOException {
        List<User> users = userRepository.findAll();
        List<Club> allClubs = clubRepository.findAll();

        // Initialize the matrix if no data present
        if (slopeOneData.isEmpty()) {
            inputData = new HashMap<>();
            // Fill all the relevant spots with zeroes
            for (User user : users) {
                HashMap<Long, Double> clubRatingMatrix = new HashMap<>();
                for (Club club : allClubs) {
                    clubRatingMatrix.put(club.getId(), 0D);
                }
                inputData.put(user.getId(), clubRatingMatrix);
            }
            SlopeOneData slopeOneDataNew = new SlopeOneData();
            slopeOneDataNew.setClubRecommendationMatrix(inputData);
            slopeOneDataNew.serializeMatrices();
            slopeOneDataRepository.save(slopeOneDataNew);
        } else {
            // Always present
            SlopeOneData toCompute = slopeOneDataRepository.findSingleInstance().get();
            toCompute.deserializeMatrices();
            inputData = toCompute.getClubRecommendationMatrix();
        }

        // Fill-in the scores of the clubs by users
        for (User user : users) {
            for (ClubLike clubLike : user.getClubLikes()) {
                inputData.get(user.getId()).put(clubLike.getClub().getId(), clubLike.getScore().doubleValue());
            }
        }
        return inputData;
    }

    private void updateUserClubRecommendations() {
        List<User> users = userRepository.findAll();
        for (User user : users) {
            HashMap<Long, Double> clubRecommendations = outputData.get(user.getId());
            if (clubRecommendations == null || clubRecommendations.isEmpty()) {
                continue; // Skip if no recommendations are present for this user
            }

            // Step 1: Get the IDs of clubs the user has already liked
            Set<Long> likedClubIds = user.getClubLikes()
                    .stream()
                    .map(clubLike -> clubLike.getClub().getId())
                    .collect(Collectors.toSet());

            // Step 2: Sort the HashMap entries by the Double priority values, excluding liked clubs
            List<Long> sortedClubIds = clubRecommendations.entrySet()
                    .stream()
                    .filter(entry -> !likedClubIds.contains(entry.getKey())) // Exclude liked clubs
                    .sorted(Map.Entry.<Long, Double>comparingByValue().reversed()) // Sort by priority (descending)
                    .map(Map.Entry::getKey) // Extract clubIds in sorted order
                    .collect(Collectors.toList());

            // Step 3: Map sorted clubIds to Club objects
            List<Club> sortedClubs = new ArrayList<>();
            for (Long clubId : sortedClubIds) {
                clubRepository.findById(clubId).ifPresent(sortedClubs::add); // Add Club to list if it exists
            }

            // Update the user's recommended clubs
            user.setRecommendedClubs(sortedClubs);
        }
    }

    @Transactional
    public void slopeOne() throws IOException {
        Optional<SlopeOneData> slopeOneData = slopeOneDataRepository.findSingleInstance();
        inputData = gatherRecommendationScoreMatrices(slopeOneData);
        System.out.println("Slope One - Before the Prediction\n");
        buildDifferencesMatrix(inputData);
        System.out.println("\nSlope One - With Predictions\n");
        predict(inputData);
        // Guaranteed to be present
        SlopeOneData actualData = slopeOneDataRepository.findSingleInstance().get();
        actualData.setClubRecommendationMatrix(inputData);
        actualData.serializeMatrices();
        slopeOneDataRepository.save(actualData);
        updateUserClubRecommendations();
    }

    /**
     * Based on the available data, calculate the relationships between the
     * items and number of occurences
     *
     * @param data
     *            existing user data and their items' ratings
     */
    private void buildDifferencesMatrix(Map<Long, HashMap<Long, Double>> data) {
        for (HashMap<Long, Double> user : data.values()) {
            for (Entry<Long, Double> e : user.entrySet()) {
                if (!diff.containsKey(e.getKey())) {
                    diff.put(e.getKey(), new HashMap<Long, Double>());
                    freq.put(e.getKey(), new HashMap<Long, Integer>());
                }
                for (Entry<Long, Double> e2 : user.entrySet()) {
                    int oldCount = 0;
                    if (freq.get(e.getKey()).containsKey(e2.getKey())) {
                        oldCount = freq.get(e.getKey()).get(e2.getKey()).intValue();
                    }
                    double oldDiff = 0.0;
                    if (diff.get(e.getKey()).containsKey(e2.getKey())) {
                        oldDiff = diff.get(e.getKey()).get(e2.getKey()).doubleValue();
                    }
                    double observedDiff = e.getValue() - e2.getValue();
                    freq.get(e.getKey()).put(e2.getKey(), oldCount + 1);
                    diff.get(e.getKey()).put(e2.getKey(), oldDiff + observedDiff);
                }
            }
        }
        for (Long j : diff.keySet()) {
            for (Long i : diff.get(j).keySet()) {
                double oldValue = diff.get(j).get(i).doubleValue();
                int count = freq.get(j).get(i).intValue();
                diff.get(j).put(i, oldValue / count);
            }
        }
        printData(data);
    }

    /**
     * Based on existing data predict all missing ratings. If prediction is not
     * possible, the value will be equal to -1
     *
     * @param data
     *            existing user data and their items' ratings
     */
    private void predict(Map<Long, HashMap<Long, Double>> data) {
        HashMap<Long, Double> uPred = new HashMap<Long, Double>();
        HashMap<Long, Integer> uFreq = new HashMap<Long, Integer>();
        List<Long> allClubIds = clubRepository.findAll()
                .stream()
                .map(Club::getId)
                .collect(Collectors.toList());

        for (Long j : diff.keySet()) {
            uFreq.put(j, 0);
            uPred.put(j, 0.0);
        }
        for (Entry<Long, HashMap<Long, Double>> e : data.entrySet()) {
            for (Long j : e.getValue().keySet()) {
                for (Long k : diff.keySet()) {
                    try {
                        double predictedValue = diff.get(k).get(j).doubleValue() + e.getValue().get(j).doubleValue();
                        double finalValue = predictedValue * freq.get(k).get(j).intValue();
                        uPred.put(k, uPred.get(k) + finalValue);
                        uFreq.put(k, uFreq.get(k) + freq.get(k).get(j).intValue());
                    } catch (NullPointerException e1) {
                    }
                }
            }
            HashMap<Long, Double> clean = new HashMap<Long, Double>();
            for (Long j : uPred.keySet()) {
                if (uFreq.get(j) > 0) {
                    clean.put(j, uPred.get(j).doubleValue() / uFreq.get(j).intValue());
                }
            }
            // We don't need the last step on clean predictions, just get, filter and sort the results.
//            for (Long j : allClubIds) {
//                if (e.getValue().containsKey(j)) {
//                    clean.put(j, e.getValue().get(j));
//                } else if (!clean.containsKey(j)) {
//                    clean.put(j, -1.0);
//                }
//            }
            outputData.put(e.getKey(), clean);
        }
        printData(outputData);
    }

    private void printData(Map<Long, HashMap<Long, Double>> data) {
        for (Long user : data.keySet()) {
            System.out.println(userRepository.findById(user).get().getUsername() + ":");
            print(data.get(user));
        }
    }

    private void print(HashMap<Long, Double> hashMap) {
        NumberFormat formatter = new DecimalFormat("#0.000");
        for (Long club : hashMap.keySet()) {
            System.out.println(" " + clubRepository.findById(club).get().getTitle() + " --> " + formatter.format(hashMap.get(club).doubleValue()));
        }
    }

}
