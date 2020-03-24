require '/Users/yamaguchishun/Documents/Ruby/AtomRuby/SciRubyExercise/PlotTemplate/gnuplotModule'

puts "Welcome"
G=GnuplotModule
#F=FrequencyDistributionModule

#関数グラフ
#GnuplotModule.plotfunc("x ** 4 + 2 * 5 ** 3 - 10 * x ** 2 + 5 * x  + 4", xmin: -5, xmax:5)

#配列からの折れ線グラフ
#GnuplotModule.plotxy([1,2,3,4,5,7], [-6,7,-3,0,8,2])

#複数の折れ線を一つの図に
#G.plotxyMulti([1,2], [5,4], [0,2], [-2,3])

#縦型棒グラフの例
#G.plotxyBox([1,2,3,4,5,6,7], [6,7,3,0,8,2,4], 1)

#ヒストグラム-----------------------
#plotHist(データ配列, 規格min., 規格max., Step)

#plotHistで呼び出すgetFreqでは、
#maxより大きい項目とminより小さい項目に一つづつ階級を設けている。
#なので、規格外はまとめてそこに入る。
dataarray = [1,6,2,36,2,6,2,34,1,5,14,2,1,5,
            62,4,2,14,-5,2,24,52,35,24,2,52,
            98,102, 64, 34, 33, 22, 23, 122]
G.plotHist(dataarray, 0, 100, 10)
#---------------------------------
