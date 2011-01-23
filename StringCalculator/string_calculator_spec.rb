require 'string_calculator'

# String Calculator
# 
#
# 1. Create a simple String calculator with a method Add(numbers) that takes a string
#
#   - The method can take 0, 1 or 2 numbers, and will return their sum (for an empty string it will return 0) for example “” or “1” or “1,2”
#   - Start with the simplest test case of an empty string and move to 1 and two numbers
#   - Remember to solve things as simply as possible so that you force yourself to write tests you did not think about
#   - Remember to refactor after each passing test
#
# 2. Allow the Add method to handle an unknown amount of numbers
# 
# 3. Allow the Add method to handle new lines between numbers (instead of commas).
# 
#   - the following input is ok:  “1\n2,3”  (will equal 6)
#   - the following input is NOT ok:  “1,\n” 
#   - Make sure you only test for correct inputs. there is no need to test for invalid inputs for these katas
# 
# 4. Allow the Add method to handle a different delimiter:
# 
#   - to change a delimiter, the beginning of the string will contain a separate line that looks like this:   
#     “//[delimiter]\n[numbers…]” for example “//;\n1;2” should return three where the default delimiter is ‘;’ .
#   - the first line is optional. all existing scenarios should still be supported
# 
# 5. Calling Add with a negative number will throw an exception “negatives not allowed” - and the negative that was
#    passed.if there are multiple negatives, show all of them in the exception message
# 
# --------------------------------------------------------------------------------------------------- 
#  stop here if you are a beginner. Continue if you can finish the steps so far in less than 30 minutes.
# ---------------------------------------------------------------------------------------------------
# 
# 6. Numbers bigger than 1000 should be ignored, so adding 2 + 1001  = 2
# 
# 7. Delimiters can be of any length with the following format:  “//[delimiter]\n” for example:
#    “//[***]\n1***2***3” should return 6
# 
# 8. Allow multiple delimiters like this:  “//[delim1][delim2]\n” for example “//[*][%]\n1*2%3” should return 6.
# 
# 9. make sure you can also handle multiple delimiters with length longer than one char

require 'string_calculator'

describe 'StringCalculator' do

  describe "add" do

    before(:each) do
      @calculator = StringCalculator.new
    end

    it "should return 0 with an empty string" do
      @calculator.add("").should == 0
    end
    
    it "should return the number with a number" do
      @calculator.add('3').should == 3
    end

    it "should return the sum with 2 or more numbers" do
      @calculator.add('3,2').should == 5
      @calculator.add('1,2,3,4,5').should == 15
    end
    
    it "should work with the '\\n' delimiter" do
      @calculator.add("3\n2").should == 5
      @calculator.add("1,2\n3").should == 6
    end
    
    it "should allow a different delimiter" do
      @calculator.add("//;\n3;2").should == 5
      @calculator.add("//;\n1,2;3").should == 6
    end
    
    it "should raise an exception if any operand is negative" do
      lambda{@calculator.add("-3")}.should raise_error 'Negatives are not allowed: -3'
      lambda{@calculator.add("-3, -5")}.should raise_error 'Negatives are not allowed: -3, -5'
      lambda{@calculator.add("//;\n-1,2;-3")}.should raise_error 'Negatives are not allowed: -1, -3'
    end
    
    it "should ignore numbers bigger than 1000" do
      @calculator.add("1,2,3,1001,2000").should == 6
    end
    
    it "should allow delimiters with any length" do
      @calculator.add("//[***]\n1***2***3").should == 6
    end
    
    it "should allow multiple custom delimiters" do
      @calculator.add("//[*][%]\n1*2%3").should == 6
    end

    it "should allow multiple custom delimiters with length longer than one char" do
      @calculator.add("//[***][%%%%%]\n1***2%%%%%3").should == 6
    end

  end
end