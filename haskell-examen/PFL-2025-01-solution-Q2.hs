data StarSystem = StarSystem String [Planet]
-- Un système stellaire est défini par :
-- String    : le nom de l'étoile
-- [Planet]  : une liste des planètes en orbite

data Planet = Planet String Int [Moon]
-- Une planète est définie par :
-- String   : son nom
-- Int      : sa masse (en unités arbitraires)
-- [Moon]   : une liste des lunes orbitant autour d'elle

data Moon = Moon String Int
-- Une lune est définie par :
-- String : son nom
-- Int    : son diamètre en kilomètres

addMoonsToPlanets :: [(String, [Moon])] -> StarSystem -> StarSystem
addMoonsToPlanets updates (StarSystem starName planets) =
  StarSystem starName (map updatePlanet planets)
  where
    updatePlanet :: Planet -> Planet
    updatePlanet (Planet name mass moons) =
      Planet name mass (moons ++ concat [moonsToAdd | (planetName, moonsToAdd) <- updates, planetName == name])
      -- On ne vérifie pas, ici, si les lunes ajoutées existaient déjà (car pas demandé dans l'énoncé)
