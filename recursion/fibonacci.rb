# Creates a list of size "number" containing fibonacci numbers
def fibs(number)
    array = [0, 1, 1]

    for i in (3...number)
        array.push(array[i - 1] + array[i - 2])
    end

    array
end

# Does the same as fibs(number) but does it recursively
def fibs_rec(number)
    if number <= 3
        return [0, 1, 1]
    else
        array = fibs_rec(number - 1)
        array.push(array[-1] + array[-2])
        array
    end
end

p fibs(10)
p fibs_rec(10)