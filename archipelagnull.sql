CREATE OR REPLACE FUNCTION where_in_the_null (crs integer) RETURNS
geometry AS $$
 
WITH null_island AS (
    SELECT ST_MakePoint(0,0) AS geom
    ),
null_island_crs AS (
    SELECT ST_SetSRID(geom, crs) AS geom FROM null_island
)
SELECT ST_Transform(geom, 4326) FROM null_island_crs
  
$$ LANGUAGE SQL VOLATILE;

DROP TABLE IF EXISTS null_archipelago;
CREATE TABLE null_archipelago AS
SELECT srid, where_in_the_null(auth_srid) FROM spatial_ref_sys
    WHERE srtext LIKE 'PROJCS%' AND auth_srid > 2000 AND auth_srid < 3000;

/*    
 SELECT * FROM spatial_ref_sys
    WHERE auth_srid > 2000 AND auth_srid < 3000;
 */