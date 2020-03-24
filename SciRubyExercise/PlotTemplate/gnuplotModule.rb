
require 'gnuplot'
require "numo/gnuplot"
require './SciRubyExercise/PlotTemplate/frequencyDistribution'

module GnuplotModule

  module_function

  def plotfunc(function, xmin:-3, xmax:3)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xrange "[" + xmin.to_s + ":" + xmax.to_s + "]"
        plot.data << Gnuplot::DataSet.new(function)
      end
    end
  end

  def plotxy(x,y)

    Gnuplot.open do |gp|
    	Gnuplot::Plot.new( gp ) do |plot|
    		plot.title  'test'
    		plot.ylabel 'ylabel'
    		plot.xlabel 'xlabel'

    		plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
    			ds.with = "lines"
    			ds.linewidth = 4 # ←線の太さを変えている
    			ds.notitle
    		end
    	end
    end
  end

  def plotxyBox(x,y,step)

    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.title  'test'
        plot.ylabel 'ylabel'
        plot.xlabel 'xlabel'

        xarrange = x.map {|elem| elem.to_f + step.to_f / 2.0 }

        plot.data << Gnuplot::DataSet.new( [xarrange, y] ) do |ds|
          ds.with = "boxes"
          ds.notitle
        end
      end
    end
  end

  def plotxyMulti(*datasets)
    #datasets は、配列の並びを引き渡す。
    #[データセット1(xの値配列)], [データセット1(y)の値配列],
    #[データセット2(xの値配列)], [データセット2(y)の値配列],
    #... という並びで実引数を定義する。

    Gnuplot.open do |gp|
    	Gnuplot::Plot.new( gp ) do |plot|
    		plot.title  'test'
    		plot.ylabel 'ylabel'
    		plot.xlabel 'xlabel'

        i=0
        datasets.each_slice(2) do |xy|
          plot.data.push(
            Gnuplot::DataSet.new([xy[0],xy[1]]) {|ds|
              ds.title = "Data #{i}"
        			ds.with = "lines"
        			ds.linewidth = 4 # ←線の太さを変えている
            }
          )
          i+=1
        end
      end
    end

  end

  def plotxyMulti_2DimArray(dataSetsArray, titleArray=[])
    #こちらの場合は、引数dataSetsArrayは一つの「二次元配列」であり、
    #[[データセット1(xの値配列)], [データセット1(y)の値配列],
    #[データセット2(xの値配列)], [データセット2(y)の値配列], ...]
    Gnuplot.open do |gp|
    	Gnuplot::Plot.new( gp ) do |plot|
    		plot.title  'test'
    		plot.ylabel 'ylabel'
    		plot.xlabel 'xlabel'

        i=0
        dataSetsArray.each_slice(2) do |xy|
          plot.data.push(
            Gnuplot::DataSet.new([xy[0],xy[1]]) {|ds|
              ds.title = titleArray[i] || "Data #{i}"
        			ds.with = "lines"
        			ds.linewidth = 4 # ←線の太さを変えている
            }
          )
          i+=1
        end
      end
    end

  end

  def plotHist(data, min, max, stepnumber)
    dataHash = FrequencyDistributionModule.getFreq(data, min, max, stepnumber)
    plotxyBox(dataHash.keys, dataHash.values, stepnumber)
  end

end
