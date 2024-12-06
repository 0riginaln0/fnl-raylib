local function merge_tables(t1, t2)
  for key, value in pairs(t2) do
    t1[key] = value
  end
  return t1
end
return {["merge-tables"] = merge_tables}
