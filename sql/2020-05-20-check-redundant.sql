SELECT ps_access.*, ps_authorization_role.slug
FROM `ps_access`
LEFT JOIN ps_authorization_role
ON ps_authorization_role.id_authorization_role = ps_access.id_authorization_role
WHERE slug IS NULL;

SELECT ps_module_access.*, ps_authorization_role.slug
FROM `ps_module_access`
LEFT JOIN ps_authorization_role
ON ps_authorization_role.id_authorization_role = ps_module_access.id_authorization_role
WHERE slug IS NULL;

