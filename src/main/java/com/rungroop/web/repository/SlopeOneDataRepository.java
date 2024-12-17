package com.rungroop.web.repository;

import com.rungroop.web.model.SlopeOneData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SlopeOneDataRepository extends JpaRepository<SlopeOneData, Long> {
    @Query("SELECT s FROM slope_one_data s WHERE s.id = 1")
    Optional<SlopeOneData> findSingleInstance();
}
