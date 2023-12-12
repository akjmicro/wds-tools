.output export.skylist
SELECT 'SkySafariObservingListVersion=3.0';
SELECT 'SkyObject=BeginObject
      ObjectID=2,-1,-1
      CatalogNumber=WDS ' || wds_num
      || '
EndObject=SkyObject'
FROM
  (
    SELECT DISTINCT(wds_num)
    FROM medium_doubles    -- change this to target ones of the preset views
                           -- or to target a view you've set up in `dbsetup.sql`.
  )
;
