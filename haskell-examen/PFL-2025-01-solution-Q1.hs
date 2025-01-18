groupBySimilarity :: Eq a => (a -> a -> Bool) -> [a] -> [[a]]
groupBySimilarity sim = foldl grouping []
  where 
    grouping currentGroups x = 
      case filter (sim x . head) currentGroups of
      [] -> [x]:currentGroups   -- Aucun groupe similaire trouvé, on crée un nouveau groupe
      (group:otherGroups) -> (x : group) : filter (/= group) currentGroups -- Sinon, on ajoute x au premier groupe trouvé, en laissant les autres groupes de l'accumulateur intacts