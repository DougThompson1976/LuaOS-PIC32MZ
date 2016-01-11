f1 = function()
    local a = 1

    print("f1")
end

f2 = function()
    local a = 1

    print("f2")
end

pthread.create(f1)
pthread.create(f2)
pthread.create(f1)
pthread.create(f2)
pthread.create(f1)
pthread.create(f2)