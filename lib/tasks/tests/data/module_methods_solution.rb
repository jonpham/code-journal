def s_say_hello
  string = "This is me saying, hello world!"
  return string
end

def s_say_words(word1, word2)
  string = "This is me saying, #{word1} #{word2}"
  return string
end

def s_say_string_array(input_array)
  string = "This is me saying, #{input_array[0]} #{input_array[1]}"
  return string
end
