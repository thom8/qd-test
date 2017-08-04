FROM proboci/ubuntu-14.04-lamp:php-7.1

ENV COMPOSER_ALLOW_SUPERUSER 1

COPY ./ /tests

# install dependencies.
RUN /tests/setup.sh

VOLUME ["/src"]

CMD ["/tests/run_tests.sh", "/src"]
