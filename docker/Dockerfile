FROM ruby:2.6.0

MAINTAINER carlos.systemred@gmail.com

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /app
WORKDIR /app

COPY Railsfiles/Gemfile Railsfiles/Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5
RUN bundle update

COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]