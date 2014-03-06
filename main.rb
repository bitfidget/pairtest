require "pry"
require "sinatra"
require "sinatra/reloader"

# everything happens at /
get "/" do

#get parameters from the URL - two params, just step and answer
  step = params[:step].to_i
  answer = params[:answer]

#setup initial variables
  @step = 1
  @question = "<p>1. Do you have a test for that?</p>"
  @yesno = true

#do the correct thing according to what 'step' you are up to
#generally - update the variables to something new each time
  case step
  when 1
    if answer == "yes"
      @step = 2
      @question = "<p>2. Does the test pass?</p>"
      @yesno = true
    else
      @step = 1
      @question = "<p>Write a test  <a href='?step=1&answer=yes'>DONE</a></p>"
      @yesno = false
    end
  when 2
    if answer == "yes"
      @step = 3
      @question = "<p>3. Need to refactor?</p>"
      @yesno = true
    else
      @step = 1
      @question = "<p>Write just enough code for the test to pass - <a href='?step=1&answer=yes'>DONE</a></p>"
      @yesno = false
    end
  when 3
    if answer == "no"
      @step = 4
      @question = "<p><a href='/'>Select a new feature to implement</a></p>"
      @yesno = false
    else
      @step = 1
      @question = "<p>Refactor the code - <a href='?step=1&answer=yes'>DONE</a></p>"
      @yesno = false
    end
  end
  # at the end serve up the form with the correct options/questions 
  erb :form
  # later - @id = params[:id]
end

# this all should flow like this:

# Do you have a test for that?
# if test=yes
# /pass = Does the test pass?
# if no
# /pass write a test [done]
# /pass = does the test pass?

# Does the test pass?
# if pass = yes
# /refactor = Need to refactor?
# if no Write just enough code for the test to pass.
# /pass = does the test pass?

# Need to refactor?
# if yes
# /do_refactor
# if no
# /select new feature to implement