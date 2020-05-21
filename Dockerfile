FROM ruby:2.6.6

COPY example.png ./

COPY repro.rb ./

CMD ["ruby", "repro.rb"]
