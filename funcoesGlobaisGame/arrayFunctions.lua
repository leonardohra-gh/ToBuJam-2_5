function ArrayFromMToN(m, n)
    local arr = {}
    for i=m, n do
        arr[i] = i
    end
    return arr
end