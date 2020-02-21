# Template Method Pattern
# Date: 18-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

#TableGenerator class
class TableGenerator

  #Creates a new instance of TableGenerator
  def initialize(header, data)
    @header = header
    @data = data
  end

  #Generates a table
  def generate
    generate_header_row + (@data.map {|x| generate_row(x)}).join
  end

  #Generates the header row of a table
  def generate_header_row
    (@header.map {|x| generate_header_item(x)}).join
  end

  #Generates an item of a table
  def generate_item(item)
    item
  end

  #Generates a row of a table
  def generate_row(row)
    (row.map {|x| generate_item(x)}).join
  end

  #Generates a header item of a table
  def generate_header_item(item)
    item
  end

end

#CSVTable class. Implements TableGenerator class
class CSVTableGenerator < TableGenerator

  #Overides the TableGenerator generate_row method
  def generate_row(row)
    "#{(row.map {|x| generate_item(x)}).join(',')}\n"
  end

  #Overides the TableGenerator generate_header_row method
  def generate_header_row
    generate_row(@header)
  end

end

#HTMLTable class. Implements TableGenerator class
class HTMLTableGenerator < TableGenerator

  #Overides the TableGenerator generate method
  def generate
    "<table>\n" + generate_header_row + (@data.map {|x| generate_row(x)}).join + "</table>\n"
  end

  #Overides the TableGenerator generate_row method
  def generate_row(row)
    "<tr>#{(row.map {|x| "<td>#{generate_item(x)}"}).join("</td>")}</td></tr>\n"
  end

  #Overides the TableGenerator generate_header_row method
  def generate_header_row
    "<tr>#{(@header.map {|x| '<th>'+generate_item(x)}).join("</th>")}</th></tr>\n"
  end

end

#AsciiDocTable class. Implements TableGenerator class
class AsciiDocTableGenerator < TableGenerator

  #Overides the TableGenerator generate method
  def generate
    "[options=\"header\"]\n" + generate_header_row + (@data.map {|x| generate_row(x)}).join + "|==========\n"
  end

  #Overides the TableGenerator generate_row method
  def generate_row(row)
    "#{(row.map {|x| "|#{generate_item(x)}" }).join("")}\n"
  end

  #Overides the TableGenerator generate_header_row method
  def generate_header_row
    "|==========\n" + generate_row(@header)
  end

end