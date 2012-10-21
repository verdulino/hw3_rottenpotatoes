
# Add a declarative step here for populating the DB with movies.

 Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # add that movie to the database here.
    Movie.create!(movie) 
  end
#  assert false, "Unimplmemented"
end

# Make sure that one string occurs before or after another one on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body =~ /(.)*#{Regexp.escape(e1)}(.)*#{Regexp.escape(e2)}/im
end

# Make it easier to express checking or unchecking several boxes at once
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  ratings = rating_list.split(%r{,\s*})
  ratings.each do |rating|
    if uncheck
      #  "When I uncheck the following ratings: PG, G, R"
      steps (%Q(When I uncheck "ratings[#{rating}]"))
    else
      #  "When I check the following ratings: G"
      steps (%Q(When I check "ratings[#{rating}]"))
    end
  end
end

Then /I should see all of the movies/ do
  numberOfRows = page.all('table tbody tr').size
  numberOfMovies = Movie.find(:all).count
  assert_equal numberOfMovies, numberOfRows
end

Then /I should not see all of the movies/ do
  numberOfRows = page.all('table tbody tr').size
  assert_equal 0, numberOfRows
end





