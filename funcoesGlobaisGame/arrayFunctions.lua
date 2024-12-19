function ArrayFromMToN(m, n)
    local arr = {}
    for i=m, n do
        table.insert(arr, i)
    end
    return arr
end