def pascal(n)
    list_pascal = []
    (0..n).each{|r|
            lst=[1]
            term=1
            k=1
            (0..r-1).step(1){|index|
                    term=term*(r-k+1)/k
                    lst.push term
                    k+=1
            }
            list_pascal << lst
    }
    list_pascal
end
print pascal("5".to_i)
