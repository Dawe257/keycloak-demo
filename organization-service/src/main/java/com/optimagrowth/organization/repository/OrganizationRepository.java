package com.optimagrowth.organization.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PostFilter;
import org.springframework.stereotype.Repository;

import com.optimagrowth.organization.model.Organization;

@Repository
public interface OrganizationRepository extends CrudRepository<Organization, String>  {

    @PostAuthorize("hasPermission(returnObject, 'READ')")
    Optional<Organization> findById(String organizationId);

    @PostFilter("hasPermission(filterObject, 'READ')")
    List<Organization> findAll();

//    Organization save(Organization organization);
}
