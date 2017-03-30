package com.shark.ocean.dao.impl;

import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.IRole;
import com.shark.ocean.model.Role;

@Repository("roleDao")
public class RoleDaoImpl extends BaseDaoImpl<Role> implements IRole {

}
