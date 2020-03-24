module FrequencyDistributionModule

  module_function

  def getFreq(data, min, max, stepnumber)

    classHash ={}

    #規格外の階級も上下に一つずつ作られるように、min-stepnumberからmaxまでイテレーション
    (min-stepnumber).step(max, stepnumber) { |x| classHash[x] = 0 }

    data.each do |d|
      classHash.keys.sort.reverse.each do |k|
        if k <= d then
          classHash[k] = classHash[k] + 1
          break
        end
      end
    end

    classHash
  end

end
