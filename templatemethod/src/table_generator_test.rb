# Template Method Pattern
# Date: 18-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'minitest/autorun'
require 'table_generator'
require 'student'

class TableGeneratorTest < Minitest::Test

  def setup
    @headerEmpty = []
    @dataEmpty = []

    @headerNums = %w{Snap Crackle Pop}
    @dataNums = [[10, 20, 30],
                 [12, 64, 13],
                 [34, 11, 29],
                 [99, 15, 34]]

    @headerStudents = %w{id name grade1 grade2 grade3 average}
    @dataStudents = [Student.new(123,
                                 "Selma Bouvier",
                                 [71, 84, 89]),
                     Student.new(241,
                                 "Carl Carlson",
                                 [78, 85, 90]),
                     Student.new(299,
                                 "Todd Flanders",
                                 [67, 71, 77]),
                     Student.new(311,
                                 "Barney Gumble",
                                 [24, 18, 35]),
                     Student.new(427,
                                 "Edna Krabappel",
                                 [92, 95, 99]),
                     Student.new(666,
                                 "Damien Thorn",
                                 [66, 66, 66]),
                     Student.new(718,
                                 "Manjula Nahasapeemapetilon",
                                 [53, 72, 88])]
  end

  def test_CSVTableGenerator
    assert_equal \
      "Snap,Crackle,Pop\n" +
      "10,20,30\n" +
      "12,64,13\n" +
      "34,11,29\n" +
      "99,15,34\n",
      CSVTableGenerator.new(@headerNums, @dataNums).generate
    assert_equal \
      "id,name,grade1,grade2,grade3,average\n" +
      "123,Selma Bouvier,71,84,89,81\n" +
      "241,Carl Carlson,78,85,90,84\n" +
      "299,Todd Flanders,67,71,77,71\n" +
      "311,Barney Gumble,24,18,35,25\n" +
      "427,Edna Krabappel,92,95,99,95\n" +
      "666,Damien Thorn,66,66,66,66\n" +
      "718,Manjula Nahasapeemapetilon,53,72,88,71\n",
      CSVTableGenerator.new(@headerStudents,
                            @dataStudents).generate
  end

  def test_HTMLTableGenerator
    assert_equal \
      "<table>\n" +
      "<tr><th>Snap</th><th>Crackle</th><th>Pop</th></tr>\n" +
      "<tr><td>10</td><td>20</td><td>30</td></tr>\n" +
      "<tr><td>12</td><td>64</td><td>13</td></tr>\n" +
      "<tr><td>34</td><td>11</td><td>29</td></tr>\n" +
      "<tr><td>99</td><td>15</td><td>34</td></tr>\n" +
      "</table>\n",
      HTMLTableGenerator.new(@headerNums, @dataNums).generate
    assert_equal \
      "<table>\n" +
      "<tr><th>id</th><th>name</th><th>grade1</th>" +
      "<th>grade2</th><th>grade3</th><th>average</th></tr>\n" +
      "<tr><td>123</td><td>Selma Bouvier</td><td>71</td>" +
      "<td>84</td><td>89</td><td>81</td></tr>\n" +
      "<tr><td>241</td><td>Carl Carlson</td><td>78</td>" +
      "<td>85</td><td>90</td><td>84</td></tr>\n" +
      "<tr><td>299</td><td>Todd Flanders</td><td>67</td>" +
      "<td>71</td><td>77</td><td>71</td></tr>\n" +
      "<tr><td>311</td><td>Barney Gumble</td><td>24</td>" +
      "<td>18</td><td>35</td><td>25</td></tr>\n" +
      "<tr><td>427</td><td>Edna Krabappel</td><td>92</td>" +
      "<td>95</td><td>99</td><td>95</td></tr>\n" +
      "<tr><td>666</td><td>Damien Thorn</td><td>66</td>" +
      "<td>66</td><td>66</td><td>66</td></tr>\n" +
      "<tr><td>718</td><td>Manjula Nahasapeemapetilon</td>" +
      "<td>53</td><td>72</td><td>88</td><td>71</td></tr>\n" +
      "</table>\n",
      HTMLTableGenerator.new(@headerStudents,
                             @dataStudents).generate
  end

  def test_AsciiDocTableGenerator
    assert_equal \
      "[options=\"header\"]\n" +
      "|==========\n" +
      "|Snap|Crackle|Pop\n" +
      "|10|20|30\n" +
      "|12|64|13\n" +
      "|34|11|29\n" +
      "|99|15|34\n" +
      "|==========\n",
      AsciiDocTableGenerator.new(@headerNums,
                                 @dataNums).generate
    assert_equal \
      "[options=\"header\"]\n" +
      "|==========\n" +
      "|id|name|grade1|grade2|grade3|average\n" +
      "|123|Selma Bouvier|71|84|89|81\n" +
      "|241|Carl Carlson|78|85|90|84\n" +
      "|299|Todd Flanders|67|71|77|71\n" +
      "|311|Barney Gumble|24|18|35|25\n" +
      "|427|Edna Krabappel|92|95|99|95\n" +
      "|666|Damien Thorn|66|66|66|66\n" +
      "|718|Manjula Nahasapeemapetilon|53|72|88|71\n" +
      "|==========\n",
      AsciiDocTableGenerator.new(@headerStudents,
                                 @dataStudents).generate
  end

end