FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cmake npm

RUN mkdir /var/app

WORKDIR /var/app

COPY Gemfile .
COPY Gemfile.lock .

RUN gem update --system && gem install bundler
RUN bundle install --jobs 4

COPY . .

CMD ["bundle", "exec", "rails", "db:environment:set RAILS_ENV=development"]
CMD ["bundle", "exec", "rails", "db:drop"]

CMD ["bundle", "exec", "rails", "db:environment:set RAILS_ENV=production"]
CMD ["bundle", "exec", "rails", "db:drop"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
