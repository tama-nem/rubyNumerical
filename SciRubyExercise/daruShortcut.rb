require 'daru'

# I was confused about daru, so I made these shortcuts.
# But now I find that these aren't useful anymore.

module DaruShortcut
  module_function

  def getDefaultDF(squareArray)
    hashExample = {}
    squareArray.each_with_index do |childArray, i|
      hashExample["col#{i}"]=childArray
    end
    Daru::DataFrame.new(hashExample)
  end

  def getDefaultDFWithLines(square_array)
    tr = square_array.transpose
    getDefaultDF(tr)
  end

  # Convert a column of df to 1-Dim. Array
  def convertArray(df, column_number)
    df.map(:row) { |row| row[column_number] }
  end

  def each_with_column(dfr)
    dfr.each { |col| col.each { yield _1 } }
  end

  def each_with_row(dfr)
    ct = dfr[1].count - 1
    0..ct.each do
      dfr.row[i].each { yield _1 }
    end
  end
end
