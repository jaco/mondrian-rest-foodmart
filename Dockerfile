FROM jruby:9

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN bundler install

COPY . .

EXPOSE 9292

CMD ["./run.sh"]