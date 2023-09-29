package com.optimagrowth.organization.controller;

import javax.annotation.security.RolesAllowed;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.acls.domain.BasePermission;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import com.optimagrowth.organization.model.Organization;
import com.optimagrowth.organization.service.OrganizationService;

import java.util.List;

@RestController
@RequestMapping(value="v1/organization")
public class OrganizationController {

    @Autowired
    private OrganizationService service;

    @RolesAllowed({ "USER" })
    @GetMapping
    public ResponseEntity<List<Organization>> getAll() {
        return ResponseEntity.ok(service.findAll());
    }

    @RolesAllowed({ "SUPER_ADMIN", "ADMIN", "USER" })
    @RequestMapping(value="/{organizationId}",method = RequestMethod.GET)
    public ResponseEntity<Organization> getOrganization( @PathVariable("organizationId") String organizationId) {
        return ResponseEntity.ok(service.findById(organizationId));
    }

    @RolesAllowed({ "ADMIN", "USER" }) 
    @RequestMapping(value="/{organizationId}",method = RequestMethod.PUT)
    public void updateOrganization( @PathVariable("organizationId") String id, @RequestBody Organization organization) {
        service.update(organization);
    }

    @RolesAllowed({ "USER" })
    @PostMapping
    public ResponseEntity<Organization>  saveOrganization(@RequestBody Organization organization, Authentication authentication) {
        service.addPermissionForUser(organization, BasePermission.WRITE, authentication.getName());
        service.addPermissionForUser(organization, BasePermission.READ, authentication.getName());
    	return ResponseEntity.ok(service.create(organization));
    }

    @RolesAllowed("ADMIN")    
    @DeleteMapping(value="/{organizationId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
	public void deleteLicense(@PathVariable("organizationId") String organizationId) {
//		service.delete(organizationId);
	}

    @RolesAllowed("SUPER_ADMIN")
    @DeleteMapping
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteAll() {
//		service.delete(organizationId);
    }
}
