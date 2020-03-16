-- DELETE BY DATE: ps_connections, ps_connections_source
DELETE FROM ps_connections WHERE date_add < 'YYYY-MM-DD';
DELETE FROM ps_connections_source WHERE date_add < 'YYYY-MM-DD';

OPTIMIZE TABLE ps_connections, ps_connections_source;

-- DELETE BY DATE: ps_cart, ps_guest
DELETE FROM ps_cart WHERE id_cart NOT IN (SELECT id_cart FROM `ps_orders`) AND date_add < 'YYYY-MM-DD';
DELETE g FROM ps_guest as g LEFT JOIN ps_cart as c ON g.id_guest = c.id_guest WHERE id_cart IS NULL;

OPTIMIZE TABLE ps_cart, ps_guest;

-- DELETE BY NULL: ps_connections
DELETE ps_connections FROM ps_connections LEFT JOIN ps_guest ON ps_connections.id_guest = ps_guest.id_guest WHERE ps_guest.id_guest IS NULL;

-- DELETE BY NULL: ps_connections_source
DELETE ps_connections_source FROM ps_connections_source LEFT JOIN ps_connections ON ps_connections_source.id_connections = ps_connections.id_connections WHERE ps_connections.id_connections IS NULL;

OPTIMIZE TABLE ps_connections, ps_connections_source;