![PuzzleNode Logo](https://github.com/mendicant-university/puzzlenode/raw/master/doc/puzzlenode.png)

PuzzleNode is a site for coders who enjoy to work on challenging problems,
and is inspired by similar efforts such as
[Project Euler](http://projecteuler.net/) and the
[Internet Problem Solving Contest](http://ipsc.ksp.sk/).

Puzzlenode is developed, maintained, and supported by
[Mendicant University](http://mendicantuniversity.org) students
and staff.

If you are not a member of Mendicant University, please get in touch through our public channels:

- **IRC:** #mendicant on freenode.net
- **Twitter:** #mendicant

## Installation

Puzzlenode is a Ruby on Rails 3 application which runs on Ruby 1.9.2 and
[PostgreSQL](http://www.postgresql.org) databases. Other databases like MySQL
or SQLite are not officially supported.

### Setting Up a Development Copy: Step by Step

To install a development version of Puzzlenode, follow these steps:

1. Fork our GitHub repository: <http://github.com/mendicant-university/puzzlenode>
2. Clone the fork to your computer
3. Run `bundle install` to install all of the dependencies
4. Create a `database.yml` file in `config`. The `config` directory contains
   an example `database.yml` for PostgreSQL.
5. Create an `omniauth.yml` file in `config`. The `config` directory contains
   an example `omniauth.yml` file.
6. Create a `config/initializers/secret_token.rb` file. The
   `config/initializers` directory contains an example `secret_token.rb` file
   with instructions for generating a secret token.
7. Create and initialize the database:

```bash
$ rake db:create
$ rake db:schema:load
```

To make things even easier, you can copy and paste this into your terminal once you've got the project cloned to your computer

```bash
gem install bundler
bundle install
bundle exec rake setup
```

Finally, run the test suite to make sure everything is working correctly:

```bash
$ rake test
```

## Contributing

Features and bugs are tracked through [Github Issues](https://github.com/mendicant-university/puzzlenode/issues).

Contributors retain copyright to their work but must agree to release their
contributions under the [Affero GPL version 3](http://www.gnu.org/licenses/agpl.html)

If you would like to help with developing PuzzleNode, please get in touch!
Our contact details are at the top of this file.

### Submitting a Pull Request

1. If a ticket doesn't exist for your bug or feature, create one on GitHub.
    - _NOTE: Don't be afraid to get feedback on your idea before you begin development work._
2. Fork the project.
3. Create a topic branch.
4. Implement your feature or bug fix.
5. Add documentation for your feature or bug fix.
6. Add tests for your feature or bug fix.
7. Run `rake test`. If your changes are not 100% covered, go back to step 5.
8. If your change affects something in this README, please update it
9. Commit and push your changes.
10. Submit a pull request.

### Contributors

Jordan Byron // [jordanbyron.com](http://jordanbyron.com) <br/>
Gregory Brown // [majesticseacreature.com](http://majesticseacreature.com/)

[Full List](https://github.com/mendicant-university/puzzlenode/contributors)

------

PuzzleNode - a [Mendicant University](http://mendicantuniversity.org) project