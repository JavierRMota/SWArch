# Template Method Pattern
# Date: 20-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#
# File name: table_generator.rb

class TableGenerator

  def initialize(header, data)
    @header = header
    @data = data
  end

  def generate
    generate_header_row + (@data.map {|x| generate_row(x)}).join
  end

  def generate_header_row
    (@header.map {|x| generate_header_item(x)}).join
  end

  def generate_item(item)
    item
  end

  def generate_row(row)
    (row.map {|x| generate_item(x)}).join
  end

  def generate_header_item(item)
    item
  end

end

class CSVTableGenerator < TableGenerator
  def generate_row(row)
    "#{(row.map {|x| generate_item(x)}).join(',')}\n"
  end

  def generate_header_row
    generate_row(@header)
  end

end

class HTMLTableGenerator < TableGenerator
  def generate
    "<table>\n"+
    generate_header_row +
    (@data.map {|x| generate_row(x)}).join +
    "</table>\n"
  end
  def generate_row(row)
    "<tr>#{(row.map {|x| generate_item("<td>#{x}</td>")}).join}</tr>\n"
  end

  def generate_header_row
    "<tr>#{(@header.map {|x| generate_item("<th>#{x}</th>")}).join}</tr>\n"
  end

end

class AsciiDocTableGenerator < TableGenerator
  def generate
    "[options=\"header\"]\n" +
    "|==========\n" +
    generate_header_row +
    (@data.map {|x| generate_row(x)}).join +
    "|==========\n"
  end
  def generate_row(row)
    "|#{(row.map {|x| generate_item(x)}).join('|')}\n"
  end

  def generate_header_row
    generate_row(@header)
  end

end
