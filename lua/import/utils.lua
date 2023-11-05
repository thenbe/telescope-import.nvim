local M = {}

M.extract_path = function(input_string)
  local extracted_string = input_string:match("['\"]([^']+)['\"]")
  return extracted_string
end

M.replace_in_quotes = function(str, replacement)
  return (str:gsub("([\"'])(.-)%1", "%1" .. replacement .. "%1"))
end

M.get_filetype = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return filetype
end

M.remove_duplicates = function(inputTable)
  local uniqueTable = {}
  local resultTable = {}

  for _, value in ipairs(inputTable) do
    if not uniqueTable[value] then
      uniqueTable[value] = true
      table.insert(resultTable, value)
    end
  end

  return resultTable
end

M.sort_by_frequency = function(inputTable)
  local frequencies = {}

  -- Count the frequencies of elements in the input table
  for _, value in ipairs(inputTable) do
    frequencies[value] = (frequencies[value] or 0) + 1
  end

  -- Create a table with pairs of elements and their frequencies
  local elementsAndFrequencies = {}
  for element, frequency in pairs(frequencies) do
    table.insert(elementsAndFrequencies, { element = element, frequency = frequency })
  end

  -- Sort the table based on frequencies in descending order
  table.sort(elementsAndFrequencies, function(a, b)
    return a.frequency > b.frequency
  end)

  local sortedTable = {}
  for _, pair in ipairs(elementsAndFrequencies) do
    for _ = 1, pair.frequency do
      table.insert(sortedTable, pair.element)
    end
  end

  return sortedTable
end

M.table_concat = function(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

return M
