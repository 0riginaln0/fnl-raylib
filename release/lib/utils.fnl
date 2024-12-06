(fn merge-tables [t1 t2]
  (each [key value (pairs t2)] 
    (tset t1 key value))
  t1)

{ : merge-tables }
